_: {
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;
}
