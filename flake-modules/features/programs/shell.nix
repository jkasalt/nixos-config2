{
  inputs,
  self,
  ...
}: let
  myShell = "zsh";
in {
  flake.modules.homeManager.shell = {...}: {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.${myShell}.enable = true;
  };

  perSystem = {pkgs, ...}: {
    hmWrappers.programs.shell = {
      mainPackage = pkgs.${myShell};
      homeModules = [self.modules.homeManager.shell];
    };
  };
}
