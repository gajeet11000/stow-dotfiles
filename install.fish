#!/usr/bin/env fish
#
# CONSTANTS #

set PACKAGES_FILE "packages.txt"

set OPTIONAL_PACKAGES \
    rustdesk-bin \
    gimp \
    kdeconnect \
    telegram-desktop \
    jdk17-openjdk \
    video-downloader \
    stacer-bin \
    masterpdfeditor-free \
    obs-studio \
    riseup-vpn \
    pamac-aur \
    dropbox \
    dropbox-cli \
    obsidian

function read_packages_from_file
    set all_packages

    while read -la package
        set all_packages $all_packages $package
    end <$PACKAGES_FILE

    echo $all_packages
end

function ask_about_optional_packages
    read -p \
        "set_color yellow; \
      echo -n '🔴 Do you want to install optional packages right now? [y/N] '; \
      set_color normal; echo -n '> '" install_optional

    # Check for empty resonse (user just hit enter) and default to NO
    if test -z "$install_optional"
        set install_optional no
        echo $install_optional
        return 0
    end

    set install_optional (string lower $install_optional)

    if test "$install_optional" = y || test "$install_optional" = yes
        set install_optional yes
    else
        set install_optional no
    end

    echo $install_optional
end

function get_essential_packages
    set all_packages $(read_packages_from_file)

    set length (count $all_packages)
    for index in (seq 1 $length)
        if test (contains -i -- "$all_packages[$index]" $OPTIONAL_PACKAGES)
            set -e all_packages[$index]
        end
    end

    echo $all_packages
end

function get_packages_to_install
    set install_optional $(ask_about_optional_packages)

    set all_packages

    if test "$install_optional" = yes
        set all_packages $(read_packages_from_file)
    else
        set all_packages $(get_essential_packages)
    end

    echo $all_packages
end

function install_packages -a packages
    yay -Syyu \
        --answerclean NotInstalled \
        --answerdiff None \
        --batchinstall \
        --needed \
        $packages
end

function install_configs
    set all_packages $(ls -d */ | grep -v "sddm/")

    echo "Installing application configs..."

    stow -t $HOME $all_packages

    echo "Installing sddm theme and config..."
    sudo cp -r sddm/themes/* /usr/share/sddm/themes/
    sudo stow -t /etc/ -d sddm/ conf/

    echo "Finished installing configs!"
end

function post_installation_configs
    #TODO complete this function
    echo hello
end

function complete_installation_funnel
    set packages_to_install $(get_packages_to_install)
    install_packages packages_to_install
    install_configs
end

function create_backup
    #BACKUP CONFIG FILES
    set config_packages $(ls -d */ | grep -Ev "sddm|dot_local|dot_scripts|dot_fonts")
    set config_packages $(string replace --all "/" "" $config_packages)
    set config_packages $(string split " " $config_packages)

    set CONFIG_DIR "$HOME/.config"
    set BACKUP_DIR "$CONFIG_DIR/backup_configs"

    mkdir -p "$BACKUP_DIR"
    for package in $config_packages
        mv "$CONFIG_DIR/$package" "$BACKUP_DIR"
    end

    # BACKING UP HOME CONFIGS
    set home_configs $(string split ' ' ".local/share/applications .scripts .fonts")
    for package in $home_configs
        mv "$HOME/$package" "$BACKUP_DIR/home_configs"
    end
end
