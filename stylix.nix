{ pkgs, ... }:
{
  stylix = {
    enable = true;
    cursor = {
      package = pkgs.banana-cursor;
      size = 24;
      name = "Banana";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    image = ./wallpapers/fog_forest_2.png;
  };

  home-manager.sharedModules = [
    {
      stylix.targets.helix.enable = false;
    }
  ];
}
