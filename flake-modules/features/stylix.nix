{inputs, ...}: {
  flake.modules.homeManager.stylix = {pkgs, ...}: {
    imports = [inputs.stylix.homeModules.stylix];
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/zenburn.yaml";
      targets.anki.enable = false;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.blex-mono;
          name = "BlexMono Nerd Font";
        };
      };
    };
  };
}
