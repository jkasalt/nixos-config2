{ inputs, self, ... }:
let
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
in
{
  flake = {
    nixosModules.lucab = {
      users = {
        users.lucab = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
        };
        groups.lucab = { };
      };
    };

    homeConfigurations.lucab = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules =
        builtins.attrValues {
          inherit (self.modules.homeManager)
            git
            shell
            emacs
            media
            syncthing
            browser
            ;
        }
        ++ [{
          home.username = "lucab";
          home.homeDirectory = "/home/lucab";
          home.stateVersion = "26.05";
        }];
    };
  };
}
