{
  flake.modules.homeManager.emacs =
    { pkgs, ... }:
    {
      programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
        extraPackages = epkgs: [
          epkgs.vterm
          (epkgs.treesit-grammars.with-grammars (g: [
            g.tree-sitter-nix
            g.tree-sitter-haskell
            g.tree-sitter-bash
          ]))
        ];
      };
      services.emacs.enable = true;
      home.packages = with pkgs; [
        ripgrep
        nil
        gcc # for tree-sitter
      ];
    };
}
