_: {
  hardware = {
    # enable nvidia drivers
    graphics.enable = true;
    nvidia = {
      open = true;
      modesetting.enable = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

}
