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
          pname = "south-theme";
          version = "0.1";
          packageRequires = with epkgs; [
            magit-section
            autothemer
          ];
          src = pkgs.fetchFromGitHub {
            owner = "SophieBosio";
            repo = "south";
            rev = "5c1bb971b97ad0ba6e56570db6479fadfd62e611";
            hash = "sha256-y035sT5pn5cIuyHb047mOzMdok6lIS/J3DTrt/yo1MI=";
          };
        })
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
    services.emacs = {
      enable = true;
      client.enable = true;
    };
    home.packages = with pkgs; [
      ripgrep
      nil # nix lsp
      cmigemo # for searching japanese buffers with romaji
      skkDictionaries.l
      sqlite
      calibre
      unzip
      # for common lisp
      sbcl
      sbclPackages.qlot-cli
      hledger
    ];
  };
}
