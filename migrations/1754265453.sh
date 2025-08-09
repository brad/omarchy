echo "Add chromium-flags.conf"

# Choose the correct chromium flags file based on software-only mode
if [ -f "$HOME/.local/state/omarchy/software-only.mode" ]; then
  cp ~/.local/share/omarchy/config/chromium-flags.x11.conf ~/.local/share/omarchy/config/chromium.conf
else
  cp ~/.local/share/omarchy/config/chromium-flags.wl.conf ~/.local/share/omarchy/config/chromium.conf
fi

~/.local/share/omarchy/bin/omarchy-refresh-config chromium-flags.conf
