{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    steam-hardware.enable = true;
  };

  environment.systemPackages = [pkgs.mangohud];

  programs.gamemode.enable = true;

  services.blueman.enable = true;
}
