_: {
  home = {
    username = "lucab";
    homeDirectory = "/home/lucab";
    stateVersion = "24.11";
  };

  gtk.enable = true;

  programs.home-manager.enable = true;

  programs = {
    direnv.enable = true;
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
    ./broot.nix
    ./zoxide.nix
    ./waybar
  ];
}
