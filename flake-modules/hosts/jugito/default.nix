{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.jugito = inputs.nixpkgs.lib.nixosSystem {
    modules = builtins.attrValues {
      inherit
        (self.nixosModules)
        jugito-base
        jugito-hardware
        jugito-disko
        niri
        lucab
        secrets
        autoUpgrade
        steam
        ;
    };
  };

  flake.nixosModules.autoUpgrade = {
    system.autoUpgrade = {
      enable = true;
      flake = "~/nixos-config2";
      flags = [
        "--print-build-logs"
        "--commit-lock-file"
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };
  };

  flake.nixosModules.jugito-base = {
    pkgs,
    config,
    ...
  }: {
    hardware = {
      enableRedistributableFirmware = true;
      bluetooth.enable = true;
    };

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      initrd.luks.devices = {
        cryptroot = {
          device = "/dev/disk/by-partlabel/luks";
          allowDiscards = true;
        };
      };
      loader = {
        systemd-boot.enable = true;
      };
    };

    services = {
      btrfs.autoScrub = {
        enable = true;
        interval = "weekly";
        fileSystems = ["/"];
      };
      upower.enable = true;
      tlp = {
        enable = false;
        settings = {
          START_CHARGE_THRESH_BAT0 = 75;
          STOP_CHARGE_THRESH_BAT0 = 85;
          START_CHARGE_THRESH_BAT1 = 75;
          STOP_CHARGE_THRESH_BAT1 = 85;
        };
      };
      fwupd.enable = true;
    };

    programs = {
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep 5 --keep-since 14d";
        flake = "~/nixos-config2";
      };
      direnv.enable = true;
    };

    networking = {
      hostName = "jugito";
      networkmanager.enable = true;
    };

    environment.systemPackages = with pkgs; [
      vim
      git
      helix
      brightnessctl
      gcc
    ];

    time.timeZone = "Asia/Tokyo";

    console.keyMap = "fr_CH";

    system.stateVersion = "25.11";

    nix.settings.extra-experimental-features = [
      "flakes"
      "nix-command"
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.symbols-only
      nerd-fonts.intone-mono
      nerd-fonts.blex-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
    ];

    i18n = {
      defaultLocale = "en_US.UTF-8";
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-mozc-ut
          fcitx5-gtk
        ];
      };
    };
  };
}
