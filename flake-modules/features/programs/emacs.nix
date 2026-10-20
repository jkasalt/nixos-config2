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
          pname = "au-themes";
          version = "0.1";
          packageRequires = with epkgs; [
            ef-themes
          ];
          src = pkgs.fetchFromGitHub {
            owner = "szymonwilczek";
            repo = "au-themes";
            rev = "b4d66b50ab1fa48eccef33551e355e658e9c5a7a";
            hash = "sha256-M3FYURCqhbllRAL5/JBv95U44ZuvnWoX5FQ216rq1e4=";
          };
        })
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
    ];
  };
}
