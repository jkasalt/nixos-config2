{inputs, ...}: {
  flake.modules.homeManager.stylix = {pkgs, ...}: {
    imports = [inputs.stylix.homeModules.stylix];
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      targets.firefox.profileNames = ["Original profile"];
    };
  };
}
