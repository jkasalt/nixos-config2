{ pkgs, ... }:
{
  stylix = {
    enable = true;
    cursor = {
      package = pkgs.banana-cursor;
      size = 24;
      name = "Banana";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    image = ./wallpapers/nix-wallpaper-nineish-dark-gray.png;

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.monaspace;
        name = "MonaspiceXe Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.monaspace;
        name = "MonaspiceAr Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts.monaspace;
        name = "MonaspiceAr Nerd Font Mono";
      };
    };
  };

  home-manager.sharedModules = [
    {
      stylix.targets = {
        # helix.enable = false;
        waybar.enable = false;
      };
    }
  ];
}
