{ pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./stylix.nix
    ./gnome.nix
    ./steam.nix
    ./nvidia.nix
    ./kanata.nix
  ];
}
