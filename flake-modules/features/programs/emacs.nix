{inputs, ...}: {
  flake.modules.homeManager.emacs = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.nix-doom-emacs-unstraightened.homeModule
    ];
    programs.doom-emacs = {
      enable = true;
      emacs = pkgs.emacs-pgtk;
      doomDir = ./doom;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.treesit-grammars.with-all-grammars
        epkgs.tree-sitter-langs
        (epkgs.melpaBuild {
          pname = "org-clock-reminder";
          version = "0.1";
          packageRequires = [];
          src = pkgs.fetchFromGitHub {
            owner = "inickey";
            repo = "org-clock-reminder";
            rev = "d3bf97113fd519aa08198e2283ba9c236a6df168";
            hash = "sha256-OsK6WC7JL2eY0ZOMv1gjn602zBRhhbpjMioThY3V0Qg=";
          };
        })
      ];
    };
    services.emacs.enable = false; # for some reason, client can't find daemon
    home.packages = with pkgs; [
      ripgrep
      nil # nix lsp
      cmigemo # for searching japanese buffers with romaji
      mozc-ut # for japanese input
      sqlite
      calibre
      unzip
    ];
  };
}
