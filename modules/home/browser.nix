{ perSystem, ... }:
{
  programs.floorp = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        settings = {
          "extensions.autoDisableScopes" = 0;
        };
        extensions = {
          packages = with perSystem.firefox-addons; [
            ublock-origin
            adnauseam
            libredirect
            sponsorblock
            sidebery
            darkreader
            istilldontcareaboutcookies
          ];
        };
      };
    };
  };
  programs.brave.enable = true;
}
