{ pkgs, flake, ... }:
{
  imports = builtins.attrValues {
    inherit (flake.homeModules)
      librewolf
      git
      helix
      nushell
      shell-utils
      waybar
      tmux
      zellij
      misc
      ;
  };

  home = {
    username = "lucab";
    homeDirectory = "/home/lucab";
    stateVersion = "24.11";
  };
  home.packages = with pkgs; [
    keepassxc
    wine64
    path-of-building
    brave
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

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ pkgs.gnomeExtensions.appindicator.extensionUuid ];
      };
    };
  };
}
