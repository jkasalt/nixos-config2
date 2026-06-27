{
  flake.modules.homeManager.ai = {
    pkgs,
    lib,
    ...
  }: {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["claude-code"];
    home.packages = with pkgs; [claude-code];
  };
}
