{ perSystem, ... }:
{
  programs.librewolf = {
    enable = true;
    profiles = {
      default = {
        settings = {
          "extensions.autoDisableScopes" = 0;
        };
        extensions = {
          packages = with perSystem.firefox-addons; [
            ublock-origin
          ];
        };
      };
    };
  };
}
