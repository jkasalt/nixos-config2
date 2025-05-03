_: {
  hardware = {
    # enable nvidia drivers
    graphics.enable = true;
    nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
