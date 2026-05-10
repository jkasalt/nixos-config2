{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.jugito = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      jugito-base
      jugito-hardware
      jugito-disko
      niri
      ly
    ];
  };

  flake.nixosModules.jugito-base =
    {
      pkgs,
      config,
      ...
    }:
    {
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
          fileSystems = [ "/" ];
        };
        power-profiles-daemon.enable = true;
        upower.enable = true;
      };

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep 5 --keep-since 3d";
        flake = config.networking.hostName;
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
        emacs-pgtk
        brightnessctl
        gcc
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
    };
}
