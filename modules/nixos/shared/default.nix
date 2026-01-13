{ pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./stylix.nix
    ./gnome.nix
    ./steam.nix
    ./nvidia.nix
    # ./kanata.nix
    # ./kde.nix
    ./appimages.nix
    ./interception-tools.nix
    ./docker.nix
  ];

  environment.systemPackages = with pkgs; [
    cargo
    rustc
    gcc
  ];
}
