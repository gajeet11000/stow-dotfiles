#!/usr/bin/env fish

function get_packages_to_install
    set packages_file "packages.txt"

    set all_packages

    while read -la package
        set all_packages $all_packages $package
    end <$packages_file

    set optional_packages \
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

    read -p \
        "set_color yellow; \
      echo -n '🔴 Do you want to install optional packages? [y/N] '; \
      set_color normal; echo -n '> '" install_optional

    # Check for empty resonse (user just hit enter) and default to NO
    if test -z "$install_optional"
        set install_optional NO
    end

    set install_optional (string lower $install_optional)

    if test "$install_optional" = y || test "$install_optional" = yes
        set install_optional true
    else
        set install_optional false
    end

    set length (count $all_packages)

    # Remove the optional packages as per the user input
    if test "$install_optional"= false
        for index in (seq 1 $length)
            if test (contains -i -- "$all_packages[$index]" $optional_packages)
                set -e all_packages[$index]
            end
        end
    end

    # Return the packages to be installed
    echo $all_packages
end

function install_packages
    set packages $(get_packages_to_install)
    yay -Syyu \
        --answerclean NotInstalled \
        --answerdiff None \
        --batchinstall \
        --needed \
        $packages
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
    set home_configs $(string split " " ".local/share/applications .scripts .fonts")
    for package in $home_configs
        mv "$HOME/$package" "$BACKUP_DIR/home_configs"
    end
end

function install_configs
    set all_packages $(ls -d */ | grep -v "sddm/")

    echo "Installing application configs..."

    stow -t $HOME $all_packages

    echo "Installing sddm theme and config..."
    sudo stow -t /usr/share/sddm/themes/ -d sddm/ themes/
    sudo stow -t /etc/ -d sddm/ conf/

    echo "Finished installing configs!"
end
