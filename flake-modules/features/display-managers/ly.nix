{...}: {
  flake.nixosModules.ly = {...}: {
    services.displayManager.enable = true;
  };
}
