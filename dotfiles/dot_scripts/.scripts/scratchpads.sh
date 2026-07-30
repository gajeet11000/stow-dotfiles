#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<EOF
Usage:
  $0 identifier="<value>" scratch="<workspace_name>" exec="<command with args>"

The identifier is matched (case-insensitively) against whichever of these
the window actually has, checked in this order: class, initialClass, title, initialTitle.

Examples:
  $0 identifier="discord" scratch="discord_special" exec="discord"
  $0 identifier="whatsapp" scratch="whatsapp_special" exec="chromium --app=https://whatsapp.com"
EOF
    exit 1
}

identifier=""
workspace_name=""
exec_cmd=""

for arg in "$@"; do
    key="${arg%%=*}"
    val="${arg#*=}"
    case "${key,,}" in
        identifier) identifier="$val" ;;
        scratch)    workspace_name="$val" ;;
        exec)       exec_cmd="$val" ;;
        *)
            echo "Error: unknown argument key '$key'" >&2
            usage
            ;;
    esac
done

if [[ -z "$identifier" || -z "$workspace_name" || -z "$exec_cmd" ]]; then
    usage
fi

# Fields to try, in order. Fed to jq as a JSON array.
fields='["class","initialClass","title","initialTitle"]'

# Returns the name of the first field (of the four) that matches on the
# first client that matches, or empty string if nothing matches at all.
find_match_field() {
    hyprctl clients -j | jq -r --arg v "$identifier" --argjson fields "$fields" '
        [ .[] as $c
          | $fields[]
          | select(($c[.] // "") | test($v; "i"))
        ] | first // empty
    '
}

matched_field="$(find_match_field)"

if [[ -z "$matched_field" ]]; then
    # Not running -> ask it to spawn directly into the special workspace, silently.
    hyprctl dispatch "hl.dsp.exec_cmd(\"$exec_cmd\", { workspace = \"special:$workspace_name silent\" })"
fi

hyprctl dispatch "hl.dsp.workspace.toggle_special(\"$workspace_name\")"