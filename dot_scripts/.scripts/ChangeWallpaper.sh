#!/bin/sh

current_session=$XDG_CURRENT_DESKTOP
dir="/mnt/Storage/PHOTOS/Wallpapers"

set_wallpaper_xfce() {
	monitor="$(xrandr --query | grep " connected" | cut -d" " -f1)"
	BG=$(find "$dir" -type f -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" | shuf -n1)
	xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor"$monitor"/workspace0/last-image -s "${BG}"
}

set_wallpaper_hyprland() {
	BG="$(find "$dir" -name '*.jpg' -o -name '*.png' | shuf -n1)"
	PROGRAM="swww"
	trans_type="simple"

	$PROGRAM img "$BG" --transition-fps 244 --transition-type $trans_type --transition-duration 0.4
}

set_wallpaper_other() {
	BG="$(find "$dir" -name '*.jpg' -o -name '*.png' | shuf -n1)"
	cat "$BG" > ~/.local/share/walls/wallpaper.jpg
	xwallpaper --zoom "$BG"
}

case "$current_session" in
"XFCE")
	set_wallpaper_xfce
	;;
"Hyprland")
	set_wallpaper_hyprland
	;;
*)
	set_wallpaper_other
	;;
esac
