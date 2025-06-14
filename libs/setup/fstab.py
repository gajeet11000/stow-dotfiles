import subprocess
import settings


def add_windows_storage_fstab():
    """
    Add Windows and Storage partitions to /etc/fstab if not already present.
    """
    windows_entry = (
        "LABEL=Windows /mnt/Windows auto nosuid,nodev,nofail,x-gvfs-show 0 0"
    )
    storage_entry = (
        "LABEL=Storage /mnt/Storage auto nosuid,nodev,nofail,x-gvfs-show 0 0"
    )
    to_add = []
    try:
        # Read current /etc/fstab
        with open(settings.FSTAB_PATH, "r") as f:
            fstab_content = f.read()
        if "LABEL=Windows" in fstab_content or "/mnt/Windows" in fstab_content:
            print("Windows partition already present in /etc/fstab.")
        else:
            to_add.append(windows_entry)
        if "LABEL=Storage" in fstab_content or "/mnt/Storage" in fstab_content:
            print("Storage partition already present in /etc/fstab.")
        else:
            to_add.append(storage_entry)
        if to_add:
            entries = "\n".join(to_add)
            subprocess.run(
                ["sudo", "bash", "-c", f'echo "{entries}" >> /etc/fstab'],
                check=True,
            )
            print("Added missing partitions to /etc/fstab.")
        else:
            print("No new partitions needed to be added to /etc/fstab.")
    except Exception as e:
        print(f"Error updating /etc/fstab: {e}")
