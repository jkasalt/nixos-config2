{ flake, ... }:
{
  imports = [ flake.homeModules.shared ];

  home = {
    username = "lucab";
    homeDirectory = "/home/lucab";
    stateVersion = "24.11";
  };
}
