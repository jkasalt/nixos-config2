{
  flake.modules.homeManager.anki = {pkgs, ...}: {
    programs.anki = {
      enable = true;
      profiles."User 1" = {
        sync = {
          autoSync = true;
          username = "lucabr123@gmail.com";
          keyFile = "/run/agenix/anki-sync-key";
        };
      };
      addons = with pkgs.ankiAddons; [
        review-heatmap
        anki-connect
        passfail2
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
