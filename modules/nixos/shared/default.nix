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
    ./scheduled-shutdown.nix
  ];

  environment.systemPackages = with pkgs; [
    cargo
    rustc
    gcc
  ];
}
