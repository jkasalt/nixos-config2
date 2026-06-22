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
    ./niri.nix
  ];


  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  environment.systemPackages = with pkgs; [
    cargo
    rustc
    gcc
  ];
}
