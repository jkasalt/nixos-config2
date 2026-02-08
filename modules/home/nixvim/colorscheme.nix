{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.lush-nvim
      pkgs.vimPlugins.zenbones-nvim
      pkgs.vimPlugins.lackluster-nvim
      pkgs.vimPlugins.poimandres-nvim
      pkgs.vimPlugins.kanso-nvim
      pkgs.vimPlugins.oasis-nvim
      pkgs.vimPlugins.koda-nvim
    ];
    extraConfigLua = ''
      vim.cmd.colorscheme("koda")
    '';
  };
}
