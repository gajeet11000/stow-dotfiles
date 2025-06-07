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
    # Check for empty response (user just hit enter) and default to NO
    if test -z "$install_optional"
        set install_optional no
        echo $install_optional
        return 0
    end
    set install_optional (string lower $install_optional)
    if test "$install_optional" = y -o "$install_optional" = yes
        set install_optional yes
    else
        set install_optional no
    end
    echo $install_optional
end

function get_essential_packages
    set all_packages (read_packages_from_file)
    set essential_packages
    for package in $all_packages
        if not contains $package $OPTIONAL_PACKAGES
            set essential_packages $essential_packages $package
        end
    end
    echo $essential_packages
end

function get_packages_to_install
    set install_optional (ask_about_optional_packages)
    set all_packages
    if test "$install_optional" = yes
        set all_packages (read_packages_from_file)
    else
        set all_packages (get_essential_packages)
    end
    echo $all_packages
end

function install_packages
    set packages $argv
    yay -S \
        --answerclean NotInstalled \
        --answerdiff None \
        --batchinstall \
        --needed \
        --noconfirm \
        $packages
end

function install_configs
    set all_packages (ls -d */ | grep -v "sddm/")
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
    set packages_to_install (get_packages_to_install)
    install_packages $packages_to_install
    install_configs
end

complete_installation_funnel
