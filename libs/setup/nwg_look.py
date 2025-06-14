import subprocess

def export_nwg_looks_settings():
    """
    Export NWG Looks settings.
    """
    try:
        subprocess.run(
            ["nwg-look", "-a"],
            check=True,
        )
        print("NWG Looks settings exported successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error exporting NWG Looks settings: {e}")