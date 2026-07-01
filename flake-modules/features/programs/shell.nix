let
  myShell = "zsh";
in {
  flake.modules.homeManager.shell = {...}: {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.${myShell}.enable = true;
  };
}
