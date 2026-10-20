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
      ];
      # Packages built from flake inputs. Overriding them here (rather than
      # adding them to extraPackages) replaces the derivations Unstraightened
      # would otherwise build from the `package!' entries in packages.el, so
      # no `:pin' is needed and flake.lock is the single source of truth.
      emacsPackageOverrides = eself: esuper: {
        au-themes = esuper.melpaBuild {
          pname = "au-themes";
          version = "0.1";
          packageRequires = with eself; [
            ef-themes
          ];
          src = inputs.au-themes;
        };
        south-theme = esuper.melpaBuild {
          pname = "south-theme";
          version = "0.1";
          packageRequires = with eself; [
            magit-section
            autothemer
          ];
          src = inputs.south-theme;
        };
        # Not the MELPA `claude-code', which is a different package
        # (yuya373/claude-code-emacs).
        claude-code = esuper.melpaBuild {
          pname = "claude-code";
          version = "0.4.5";
          packageRequires = with eself; [
            transient
            inheritenv
          ];
          src = inputs.claude-code-el;
        };
        monet = esuper.melpaBuild {
          pname = "monet";
          version = "0.0.3";
          packageRequires = with eself; [
            websocket
          ];
          src = inputs.monet;
        };
      };
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
