_: {
  hardware = {
    # enable nvidia drivers
    graphics.enable = true;
    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # Attempt at fixing a bug where putting the system to sleep would make the
  # computer unusable. Didn't work, unfortunately.
  systemd.services."systemd-suspend" = {
    serviceConfig.Environment = ''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
  };

}
