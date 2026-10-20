{inputs, ...}: {
  flake.nixosModules.steam = {
    pkgs,
    lib,
    ...
  }: {
    programs.steam.enable = true;
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-unwrapped"
      ];
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };

  flake.modules.homeManager.geforce-now = {pkgs, ...}: {
    imports = [inputs.flatpaks.homeModules.default];
    home.packages = [pkgs.flatpak];
    services.flatpak = {
      enable = true;
      remotes = {
        "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      };
      packages = ["flathub:app/io.github.hmlendea.geforcenow-electron/x86_64/master"];
      runWithoutGui = true;
      overrides = {
      # note: "global" is a flatpak thing
      # if you ever ran "flatpak override" without specifying a ref you will know
      "global".Context = {
        filesystems = [
          "home"
        ];
        sockets = [
          "!x11"
          "!fallback-x11"
        ];
      };
      "org.mozilla.Firefox" = {
        Environment = {
          "MOZ_ENABLE_WAYLAND" = 1;
        };
        Context.sockets = [
          "!wayland"
          "!fallback-x11"
          "x11"
        ];
      };
        };
    };
  };
}
