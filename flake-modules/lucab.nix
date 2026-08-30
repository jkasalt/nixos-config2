{
  inputs,
  self,
  ...
}: let
  pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
in {
  flake = {
    nixosModules.lucab = {
      programs.zsh.enable = true;
      users = {
        users.lucab = {
          isNormalUser = true;
          shell = pkgs.zsh;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
        };
        groups.lucab = {};
      };
    };

    homeConfigurations.lucab = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules =
        builtins.attrValues {
          inherit
            (self.modules.homeManager)
            git
            shell
            media
            passwords
            syncthing
            browser
            ai
            anki
            email
            niri
            fcitx5
            emacs
            ;
        }
        ++ [
          {
            home.username = "lucab";
            home.homeDirectory = "/home/lucab";
            home.stateVersion = "26.05";
          }
        ];
    };
  };
}
