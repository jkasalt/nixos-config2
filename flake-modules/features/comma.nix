{
  flake.nixosModules.comma = _: {
    programs = {
      comma = {
        enable = true;
        enableZshIntegration = true;
      };
      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
