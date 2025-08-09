#!/bin/bash

# Prompt for 3D acceleration
if [ -z "$OMARCHY_SOFTWARE_ONLY" ]; then
  echo "\nDo you have 3D acceleration (GPU drivers, hardware rendering)? [Y/n]"
  read -r has3d
  if [[ -z "$has3d" || "$has3d" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    export OMARCHY_SOFTWARE_ONLY=0
    rm -f ~/.local/state/omarchy/software-only.mode
  else
    export OMARCHY_SOFTWARE_ONLY=1
    touch ~/.local/state/omarchy/software-only.mode
  fi
fi

# Install common dependencies
yay -S --noconfirm --needed \
  walker-bin libqalculate xdg-desktop-portal-gtk polkit-gnome

if [ "$OMARCHY_SOFTWARE_ONLY" = "1" ]; then
  # Install software-only dependencies and desktop file
  yay -S --noconfirm --needed \
    polybar dunst picom i3-wm betterlockscreen dmenu feh \
    xorg-server xorg-xinit
  sudo mkdir -p /usr/share/xsessions
  sudo tee /usr/share/xsessions/i3.desktop <<EOF
[Desktop Entry]
Name=i3
Comment=A tiling window manager
Exec=i3
Type=Application
EOF
else
  # Install hardware-accelerated dependencies and desktop file
  yay -S --noconfirm --needed \
    waybar mako swaybg swayosd hyprland hyprshot hyprpicker \
    hyprlock hypridle hyprsunset hyprland-qtutils \
    xdg-desktop-portal-hyprland
  sudo mkdir -p /usr/share/wayland-sessions
  sudo tee /usr/share/wayland-sessions/hyprland.desktop <<EOF
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
fi
