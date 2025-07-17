{
  inputs,
  pkgs,
  ...
}:
let
  inherit (pkgs) system;
  firefox-addons = inputs.firefox-addons.outputs.packages.${system};
in
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
          packages = with firefox-addons; [
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

  stylix.targets.floorp.profileNames = [ "default" ];
  programs.brave.enable = true;
}
