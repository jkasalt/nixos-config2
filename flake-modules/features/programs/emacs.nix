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
