{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
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
    extraPlugins = with pkgs.vimPlugins; [ miasma-nvim ];
    plugins.indent-blankline.enable = true;
  };
}
