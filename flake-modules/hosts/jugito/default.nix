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
        steam
        comma
        fcitx5
        # dns-over-tls
        vpn
        ;
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
      firewall.allowedTCPPorts = [3000]; # For development with lynxJS
      hostName = "jugito";
      networkmanager.enable = true;
    };

    # Some hosts (e.g. Infomaniak's mail servers) advertise AAAA records
    # whose IPv6 endpoints aren't actually reachable here; isync/mbsync has
    # no Happy Eyeballs, so it dials each address in order and hangs on
    # both IPv6 addresses before falling back to IPv4. Deprioritizing IPv6
    # in glibc's address selection (without disabling it) skips that.
    environment.etc."gai.conf".text = "precedence ::ffff:0:0/96  100\n";

    environment.systemPackages = with pkgs; [
      vim
      git
      helix
      brightnessctl
      gcc
      adwaita-icon-theme
    ];

    time.timeZone = "Asia/Tokyo";

    console.keyMap = "fr_CH";

    system.stateVersion = "25.11";

    nix.settings = {
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
      auto-optimise-store = true;
    };

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.symbols-only
      nerd-fonts.intone-mono
      nerd-fonts.blex-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];

    fonts.fontconfig.localConf = ''
  <match target="font">
    <test name="family" compare="contains">
      <string>FiraCode Nerd Font</string>
    </test>
    <edit name="fontfeatures" mode="append">
      <string>ss09</string>
      <string>cv25</string>
      <string>cv26</string>
      <string>cv32</string>
      <string>zero</string>
      <string>onum</string>
    </edit>
  </match>
'';

    i18n.defaultLocale = "en_US.UTF-8";
  };

  flake.nixosModules.dns-over-tls = {
    networking.nameservers = ["1.1.1.1#cloudflare-dns.com" "9.9.9.9#dns.quad9.net"];
    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSOverTLS = "opportunistic";
        DNSSEC = true;
        Domains = ["~."];
        FallbackDNS = ["1.1.1.1" "9.9.9.9"];
      };
    };
  };

  flake.nixosModules.vpn = {pkgs, ...}: {
    services.mullvad-vpn = {
      enable = true;
      enableEarlyBootBlocking = true;
      enableExcludeWrapper = false;
    };
    environment.systemPackages = with pkgs; [mullvad-compass];
  };
}
