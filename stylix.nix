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

    fonts.sansSerif = {
      package = pkgs.nerd-fonts.monaspace;
      name = "Monaspice Nerd Font";
    };
  };

  home-manager.sharedModules = [
    {
      stylix.targets = {
        helix.enable = false;
        waybar.enable = false;
      };
    }
  ];
}
