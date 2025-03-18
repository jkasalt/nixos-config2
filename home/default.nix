_: {
  home = {
    username = "lucab";
    homeDirectory = "/home/lucab";
    stateVersion = "24.11";
  };

  gtk.enable = true;

  programs.home-manager.enable = true;

  programs = {
    yazi.enable = true;
    direnv.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
    };
  };

  imports = [
    ./hyprland.nix
    ./firefox.nix
    ./helix.nix
    ./nushell.nix
    ./broot.nix
    ./zoxide.nix
  ];
}
