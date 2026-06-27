{
  flake.modules.homeManager.anki = {pkgs, ...}: {
    programs.anki = {
      enable = true;
      addons = with pkgs.ankiAddons; [
        review-heatmap
        (fsrs4anki-helper.withConfig {
          config = {
            auto_reschedule_after_sync = true;
            auto_disperse_after_reschedule = true;
          };
        })
      ];
    };
  };
}
