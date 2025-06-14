import subprocess

from packages import ARCH_PACKAGES, AUR_PACKAGES


class PackageInstaller:
    def install_packages(self):
        """
        Install all packages.
        """
        all_packages = ARCH_PACKAGES | AUR_PACKAGES

        main_command = [
            "yay",
            "-Syu",
            "--noconfirm",
            "--needed",
            "--answerdiff",
            "None",
            "--answerclean",
            "NotInstalled",
        ]

        cmd = main_command + list(all_packages)
        try:
            subprocess.run(cmd, check=True)
            print("All packages installed successfully.")
        except subprocess.CalledProcessError as e:
            print("Error installing all packages", e)
