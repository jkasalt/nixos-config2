{ pkgs, ... }:
{
  imports = [
    ../../../../modules/home/browser.nix
    ../../../../modules/home/git.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/nushell.nix
    ../../../../modules/home/shell-utils.nix
    ../../../../modules/home/tmux.nix
    ../../../../modules/home/zellij.nix
    ../../../../modules/home/misc.nix
    ../../../../modules/home/gh.nix
  ];

  home = {
    username = "lucab";
    homeDirectory = "/home/lucab";
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    keepassxc
    wine64
  ];

  programs.home-manager.enable = true;

  programs = {
    lazygit.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep 5 --keep-since 3d";
    };
    yazi.enable = true;
  };
}
