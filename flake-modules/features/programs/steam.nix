{
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
}
