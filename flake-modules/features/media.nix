{ moduleWithSystem, ... }:
{
  flake.modules.homeManager.media = moduleWithSystem (
    { inputs', ... }:
    { pkgs, ... }:
    {
      home.packages = [
        inputs'.curd.packages.default
        pkgs.qbittorrent
      ];
    }
  );
}
