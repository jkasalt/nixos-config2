{ pkgs, ... }:
{

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment.systemPackages = [ pkgs.wl-clipboard ];
  programs.xwayland.enable = true;
}
