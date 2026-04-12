#!/usr/bin/env bash
# devkit-toolkit: shared hook merging library
# Sourced by adapters that need to merge hooks from resolved plugins.
#
# Requires: jq, resolve.sh already sourced (for _build_plugin_index)
#
# Exports:
#   merge_plugin_hooks  — merge all resolved plugins' hooks into a single JSON object
#
# Plugin hooks format (Claude Code canonical):
#   { "hooks": { "EventName": [{ "matcher": "...", "command": "...", "timeout_ms": N }] } }
#
# The merged output has the same shape, with arrays concatenated per event type.
# Each adapter is responsible for translating event names to its target tool's format.

merge_plugin_hooks() {
  local plugin_index="$1"
  local resolved_names="$2"
  local merged='{}'

  while IFS= read -r name; do
    [ -z "$name" ] && continue
    local plugin_data
    plugin_data=$(echo "$plugin_index" | jq --arg name "$name" '.[$name]')
    local plugin_dir
    plugin_dir=$(echo "$plugin_data" | jq -r '._dir')
    local hooks_path
    hooks_path=$(echo "$plugin_data" | jq -r '.paths.hooks // empty')

    if [ -z "$hooks_path" ]; then
      continue
    fi

    local hooks_file="$plugin_dir/$hooks_path"
    if [ ! -f "$hooks_file" ]; then
      continue
    fi

    local plugin_hooks
    plugin_hooks=$(jq '.hooks // {}' "$hooks_file" 2>/dev/null || echo '{}')

    if [ "$plugin_hooks" = '{}' ]; then
      continue
    fi

    merged=$(echo "$merged" | jq --argjson new "$plugin_hooks" --arg source "$name" '
      reduce ($new | to_entries[]) as $entry (
        .;
        .[$entry.key] = ((.[$entry.key] // []) + [$entry.value[] | . + {_plugin: $source}])
      )
    ')
  done <<< "$resolved_names"

  echo "$merged"
}

# Event name mapping: Claude Code → Cursor
# Claude Code events: PreToolUse, PostToolUse, Notification, Stop, SubagentStop
# Cursor events:      beforeShellExecution, afterFileEdit, beforeSubmitPrompt, etc.
#
# Not all events map 1:1. This function translates where possible
# and drops events that have no Cursor equivalent.
translate_hooks_to_cursor() {
  local merged_hooks="$1"

  echo "$merged_hooks" | jq '
    {
      "PreToolUse":    "beforeShellExecution",
      "PostToolUse":   "afterFileEdit",
      "Stop":          "afterResponse"
    } as $event_map |

    reduce (to_entries[]) as $entry (
      {};
      if ($event_map[$entry.key] != null) then
        .[$event_map[$entry.key]] = (
          (.[$event_map[$entry.key]] // []) +
          [$entry.value[] | del(._plugin)]
        )
      else . end
    )
  '
}

# Strip internal metadata (_plugin, _comment) from hooks for clean output
clean_hooks() {
  local hooks="$1"
  echo "$hooks" | jq '
    map_values([.[] | del(._plugin)])
  '
}
