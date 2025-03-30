{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
  ];

  gtk.enable = true;

  programs.home-manager.enable = true;

  programs = {
    kitty.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep 5 --keep-since 3d";
    };
    yazi.enable = true;
  };

  imports = [
    ./hyprland.nix
    ./firefox.nix
    ./helix.nix
    ./nushell.nix
    # ./shell-utils.nix
    ./waybar
    ./neovim
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
