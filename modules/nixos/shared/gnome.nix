_: {
  services = {
    xserver = {
      enable = true;
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.cosmic.enable = true;
  };
  programs.xwayland.enable = true;
}
