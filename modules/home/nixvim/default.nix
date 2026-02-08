{ pkgs, ... }:
{
  imports = [
    ./languages
    ./plugins
    ./keymaps.nix
    ./lsp.nix
    ./colorscheme.nix
  ];

  programs.nixvim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
    globals.mapleader = " ";
    extraPlugins = [ pkgs.vimPlugins.miasma-nvim ];
  };
}
