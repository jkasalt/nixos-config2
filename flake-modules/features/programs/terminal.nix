{
  flake.modules.homeManager.terminal = {lib, pkgs, ...}: {
    programs.kitty = {
      enable = true;
    };
  };
}
