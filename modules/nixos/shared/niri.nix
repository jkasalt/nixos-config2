{inputs, ...}: let inherit (inputs) niri; in {
  imports = [
    niri.nixosModules.niri
  ];

  nixpkgs.overlays = [ niri.overlays.niri ];

  programs.niri = {
    enable = true;
  };
}
