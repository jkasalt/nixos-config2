{ pkgs, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    cursor = {
      package = pkgs.banana-cursor;
      size = 24;
      name = "Banana";
    };
    base16Scheme = "${inputs.tt-schemes}/base16/chalk.yaml";
    image = ./wallpapers/nix-wallpaper-nineish-dark-gray.png;

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        name = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
      };
      monospace = {
        # package = pkgs.nerd-fonts.blex-mono;
        # name = "BlexMono Nerd Font Mono";
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
    };

  };

  home-manager.sharedModules = [
    {
      stylix.targets = {
        helix.enable = false;
        librewolf.profileNames = [ "default" ];
      };
    }
  ];
}
