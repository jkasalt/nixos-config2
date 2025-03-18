{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    wofi
    kdePackages.dolphin
  ];
}
