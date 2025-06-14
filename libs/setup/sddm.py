import os
import glob
import subprocess
import settings


def sddm_theme_config():
    """
    Copy SDDM themes and stow SDDM config.
    """
    try:
        themes_dir = os.path.join(settings.DOTFILES_DIR, "sddm", "themes")
        themes = glob.glob(os.path.join(themes_dir, "*"))

        if not themes:
            print("No themes found to copy.")
            return

        subprocess.run(
            ["sudo", "cp", "-r"] + themes + [settings.SYSTEM_SDDM_THEMES_DIR],
            check=True,
        )

        subprocess.run(
            [
                "sudo",
                "stow",
                "-t",
                "/etc/",
                "-d",
                os.path.join(settings.DOTFILES_DIR, "sddm"),
                "conf/",
            ],
            check=True,
        )
        print("SDDM theme and config installed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error configuring SDDM theme: {e}")
