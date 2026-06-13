{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = [pkgs.mangohud];

  programs.gamemode.enable = true;
}
