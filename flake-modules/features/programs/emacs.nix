{
  flake.modules.homeManager.emacs =
    { pkgs, lib, ... }:
    {
      programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
        extraPackages = epkgs: [
          epkgs.vterm
          epkgs.treesit-grammars.with-all-grammars
        ];
      };
      services.emacs.enable = true;
      home.packages = with pkgs; [
        ripgrep
        nil # nix lsp
        git-sync # for org-mode sync
        cmigemo # for searching japanese buffers with romaji
        mozc-ut # for japanese input
      ];
      systemd.user = {
        services.git-sync-org = {
          Unit = {
            Description = "Performs git sync in the org directory";
          };
          Service = {
            Type = "simple";
            ExecStart = pkgs.writeShellScript "org-sync" ''
              cd ~/org || exit 1
              ${lib.getExe' pkgs.git-sync "git-sync"}
            '';
            Nice = 19;
          };
        };
        timers.git-sync-org = {
          Unit = {
            Description = "Performs git sync in the org directory";
          };
          Timer = {
            OnBootsec = "1min";
            OnUnitActiveSec = "5min";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
}
