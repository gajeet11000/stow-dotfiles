#!/bin/bash

# Directory to monitor
MONITORED_DIR="$HOME/Documents"
VSCODE_WORKSPACE="$HOME/Documents/VSCode Workspace"

# Function to handle folder creation
handle_folder_create() {
  local folder_path="$1"
  local folder_name=$(basename "$folder_path")
  local file_path="${VSCODE_WORKSPACE}/${folder_name}.code-workspace"

  local vscode_workspace_config="
    {
      \"folders\": [
        {
          \"path\": \"../${folder_name}\"
        }
      ]
    }
  "

  echo "$vscode_workspace_config" >"$file_path"
  echo "File created: $file_path"
}

# Function to handle folder deletion
handle_folder_delete() {
  local folder_path="$1"
  local folder_name=$(basename "$folder_path")
  local file_path="${VSCODE_WORKSPACE}/${folder_name}.code-workspace"

  if [ -f "$file_path" ]; then
    rm "$file_path"
    echo "File deleted: $file_path"
  fi
}

handle_folder_delete "/home/gajeet/Desktop/"
# Monitor the directory for create and delete events
inotifywait -m -e create -e delete -e moved_to -e moved_from --format '%e %w%f' "$MONITORED_DIR" | while read event full_path; do
  if [[ $event == "CREATE,ISDIR" && -d "$full_path" ]]; then
    handle_folder_create "$full_path"
  elif [[ ($event == "DELETE,ISDIR" || $event == "MOVED_FROM,ISDIR" || $event == "MOVED_TO,ISDIR") && ! -d "$full_path" ]]; then
    handle_folder_delete "$full_path"
  fi
done
