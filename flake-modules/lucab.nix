{ inputs, self, ... }:
let
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
in
{
  flake = {
    homeConfigurations.lucab = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = with self.modules.homeManager; [
        {
          home.username = "lucab";
          home.homeDirectory = "/home/lucab";
          home.stateVersion = "26.05";
        }
        git
        shell
      ];
    };
  };
}
