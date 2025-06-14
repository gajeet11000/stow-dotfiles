import os
import subprocess
import settings


class StowConfig:
    def _is_stowable(self, entry):
        """
        Check if the entry is a directory and not excluded.
        """
        full_path = os.path.join(settings.DOTFILES_DIR, entry)
        return (
            os.path.isdir(full_path)
            and entry not in settings.EXCLUDED_DIRS
            and not entry.startswith(".")
        )

    def _get_stow_dirs(self):
        """
        Get a list of directories to stow.
        This function can be modified to return specific directories if needed.
        """
        stow_dirs = []
        for dir in os.listdir(settings.DOTFILES_DIR):
            if self._is_stowable(dir):
                stow_dirs.append(dir)
        return stow_dirs

    def stow_config(self, stow_dir):
        """
        Stow or restow a config directory.
        Uses --restow if already stowed, otherwise uses stow.
        """
        print(f"Stowing {stow_dir}...")
        cmd = ["stow", "--restow", "--adopt", "--target", settings.HOME_DIR, stow_dir]
        try:
            subprocess.run(cmd, cwd=settings.DOTFILES_DIR, check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error stowing {stow_dir}: {e}")

    def unstow_config(self, stow_dir):
        """
        Unstow a config directory.
        """
        print(f"Unstowing {stow_dir}...")
        cmd = ["stow", "--delete", "--target", settings.HOME_DIR, stow_dir]
        try:
            subprocess.run(cmd, cwd=settings.DOTFILES_DIR, check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error unstowing {stow_dir}: {e}")

    def stow_all_configs(self):
        """
        Stow all config directories.
        """
        stow_dirs = self._get_stow_dirs()
        if not stow_dirs:
            print("No directories to stow.")
            return

        for stow_dir in stow_dirs:
            self.stow_config(stow_dir)

    def unstow_all_configs(self):
        """
        Unstow all config directories.
        """
        stow_dirs = self._get_stow_dirs()
        if not stow_dirs:
            print("No directories to unstow.")
            return

        for stow_dir in stow_dirs:
            self.unstow_config(stow_dir)
