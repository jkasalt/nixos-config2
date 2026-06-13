{
  pkgs,
  lib,
  ...
}:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = ./wallpapers/luminescent.jpg;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };

    targets.qt.platform = lib.mkForce "qtct";
  };

  home-manager.sharedModules = [{
    stylix.targets.emacs.enable = false; 
    stylix.targets.neovim.enable = false;
  }];
}
