{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    wofi
    kdePackages.dolphin
  ];
}
