import subprocess
import settings


def change_shell():
    """
    Change the default shell to fish for the current user.
    """

    try:
        subprocess.run(["chsh", "-s", settings.FISH_SHELL_PATH], check=True)
        subprocess.run(["sudo", "chsh", "-s", settings.FISH_SHELL_PATH], check=True)
        print(
            "Shell change requested. Please restart your session for the changes to take effect."
        )
    except subprocess.CalledProcessError as e:
        print(f"Error changing shell to fish: {e}")


def set_fish_colorscheme():
    """
    Set the fish colorscheme to 'Catppuccin Mocha'.
    """
    try:
        subprocess.run(
            ["fish", "fish_config", "theme", "save", "Catppuccin Mocha"],
            check=True,
        )
        print("Fish colorscheme set to 'Catppuccin Mocha'.")
    except subprocess.CalledProcessError as e:
        print(f"Error setting fish colorscheme: {e}")
