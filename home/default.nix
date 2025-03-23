{ pkgs, ... }:
{
  home = {
    username = "lucab";
    homeDirectory = "/home/lucab";
    stateVersion = "24.11";
  };

  gtk.enable = true;

  programs.home-manager.enable = true;

  programs = {
    kitty.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
    };
    yazi.enable = true;
  };

  imports = [
    ./hyprland.nix
    ./firefox.nix
    ./helix.nix
    ./nushell.nix
    ./shell-utils.nix
    ./waybar
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ pkgs.gnomeExtensions.appindicator.extensionUuid ];
      };
    };
  };
}
