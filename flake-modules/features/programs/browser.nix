{
  flake.modules.homeManager.browser =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        package = pkgs.librewolf;
      };

      programs.nyxt.enable = true;
    };
}
