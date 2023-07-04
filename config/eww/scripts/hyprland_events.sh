#!/usr/bin/env bash

NUMBER_OF_WORKSPACES=9

workspaces() {
  WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
  seq 1 $NUMBER_OF_WORKSPACES | jq --argjson windows "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
}

if [[ $1 == 'workspaces' ]]; then
  echo "{ \"workspaces\": $(workspaces), \"active\": 1, \"active_empty\": true }"

  socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    active=$(eww get workspaces | jq .active)
    if [[ ${line:0:9} == 'workspace' ]]; then
      active=${line:11}
    fi

    active_empty='true'
    let "i = $active - 1"
    if [[ $(workspaces | jq --raw-output .[$i].windows) -gt 0 ]]; then
      active_empty='false'
    fi

    eww update workspaces="{
      \"workspaces\": $(workspaces),
      \"active\": $active,
      \"active_empty\": $active_empty
    }"
  done
fi
