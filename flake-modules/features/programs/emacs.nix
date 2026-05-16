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
        cmigemo # for searching japanese buffers with romaji
        mozc-ut # for japanese input
      ];
    };
}
