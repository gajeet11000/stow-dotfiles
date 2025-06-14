import argparse

from libs.package import PackageInstaller
from libs.post_install import post_install
from libs.setup.nwg_look import export_nwg_looks_settings
from libs.stow import StowConfig


def main():
    parser = argparse.ArgumentParser(description="Arch Linux Post-Install Helper")
    subparsers = parser.add_subparsers(dest="command", required=True)

    subparsers.add_parser("install-packages", help="Install all packages using yay")
    subparsers.add_parser("stow-configs", help="Stow all dotfiles configs")
    subparsers.add_parser(
        "post-install-configs", help="Run post-install configuration tasks"
    )
    subparsers.add_parser("unstow-configs", help="Unstow all dotfiles configs")
    subparsers.add_parser("apply-gtk", help="Export NWG Looks GTK settings")

    args = parser.parse_args()

    if args.command == "install-packages":
        PackageInstaller().install_packages()
    elif args.command == "stow-configs":
        StowConfig().stow_all_configs()
    elif args.command == "post-install-configs":
        post_install()
    elif args.command == "unstow-configs":
        StowConfig().unstow_all_configs()
    elif args.command == "apply-gtk":
        export_nwg_looks_settings()
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
