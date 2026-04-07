{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./disks.nix
    ./hardware-configuration.nix
    ../../modules/nixos/shared/niri.nix
  ];

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  boot.initrd.luks.devices = {
    cryptroot = {
      device = "/dev/disk/by-partlabel/luks";
      allowDiscards = true;
    };
  };

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  networking.hostName = "jugito";

  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    helix
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    firefox
  ];

  time.timeZone = "Europe/Zurich";

  users.users.lucab = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkManager"
    ];
  };

  users.groups.lucab = { };

  console.keyMap = "fr_CH";

  system.stateVersion = "25.11";

  nix.settings.extra-experimental-features = [
    "flakes"
    "nix-command"
  ];
}
