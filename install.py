import os
import subprocess

# List the directories you want to exclude from stowing
EXCLUDED_DIRS = {"sddm"}

def main():
    # Get the directory where the script is located
    script_dir = os.path.abspath(os.path.dirname(__file__))
    home_dir = os.path.expanduser("~")

    # Loop through all items in the script directory
    for entry in os.listdir(script_dir):
        full_path = os.path.join(script_dir, entry)

        # Skip non-directories, excluded dirs, and hidden dirs
        if not os.path.isdir(full_path):
            continue
        if entry in EXCLUDED_DIRS or entry.startswith('.'):
            continue

        print(f"Stowing: {entry}")
        try:
            subprocess.run(["stow", "-t", home_dir,  entry], cwd=script_dir, check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error stowing {entry}: {e}")

if __name__ == "__main__":
    main()

