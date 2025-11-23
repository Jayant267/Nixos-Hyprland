echo "Processing File: configuration.nix"
diff Downloads/Nixos\ Hyprland/nixos/configuration.nix /etc/nixos/configuration.nix
echo "Processing File: hyprland.conf"
diff Downloads/Nixos\ Hyprland/hyprland/hyprland.conf .config/hypr/hyprland.conf
echo "Processing File: config.kdl"
diff Downloads/Nixos\ Hyprland/niri/config.kdl .config/niri/config.kdl
echo "Processing File: config"
diff Downloads/Nixos\ Hyprland/sway/config .config/sway/config
echo "Processing File: config.jsonc"
diff Downloads/Nixos\ Hyprland/Both\ Waybar/config.jsonc .config/waybar/config.jsonc
echo "Processing File: style.css"
diff Downloads/Nixos\ Hyprland/Both\ Waybar/style.css .config/waybar/style.css


