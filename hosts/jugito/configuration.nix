{ config, lib, pkgs, ... }:

{
  imports = [
    ./disks.nix
  ];

  boot.initrd.luks.devices = {
    cryptroot = {
      device = "/dev/disk/by-partlabel/luks";
      allowDiscards = true;
    };
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = ["/"];
  };

  networking.hostName = "jugito";

  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  time.timeZone = "Europe/Zurich";

  users.users.lucab = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkManager"];
  };

  users.groups.lucab = {};

  console.keyMap = "fr_CH";

  system.stateVersion = "25.11";
}
