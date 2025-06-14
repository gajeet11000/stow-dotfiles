import setup


def post_install():
    """
    Post-installation tasks.
    """
    setup.change_shell()
    setup.set_fish_colorscheme()
    setup.export_nwg_looks_settings()
    setup.add_windows_storage_fstab()
    setup.sddm_theme_config()
    setup.docker_setup()
