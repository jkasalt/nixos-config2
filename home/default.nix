_: {
  home = {
    username = "lucab";
    homeDirectory = "/home/lucab";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  imports = [./hyprland.nix];
}
