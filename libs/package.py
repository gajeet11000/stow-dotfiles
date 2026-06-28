import subprocess

from packages import ARCH_PACKAGES, AUR_PACKAGES, FLATPAK_PACKAGES


class PackageInstaller:
    def install_packages(self):
        """Install Arch, AUR, and Flatpak packages."""

        # Install Arch + AUR packages
        all_packages = ARCH_PACKAGES | AUR_PACKAGES

        yay_cmd = [
            "yay",
            "-Syu",
            "--noconfirm",
            "--needed",
            "--answerdiff",
            "None",
            "--answerclean",
            "NotInstalled",
            *sorted(all_packages),
        ]

        try:
            subprocess.run(yay_cmd, check=True)
            print("Arch/AUR packages installed successfully.")
        except subprocess.CalledProcessError as e:
            print(f"Error installing Arch/AUR packages: {e}")
            return

        # Install Flatpak packages
        if FLATPAK_PACKAGES:
            flatpak_cmd = [
                "flatpak",
                "install",
                "-y",
                "flathub",
                *sorted(FLATPAK_PACKAGES),
            ]

            try:
                subprocess.run(flatpak_cmd, check=True)
                print("Flatpak packages installed successfully.")
            except subprocess.CalledProcessError as e:
                print(f"Error installing Flatpak packages: {e}")
