{inputs, pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "oasis.nvim";
        src = inputs.oasis-nvim.outPath;
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "koda.nvim";
        src = inputs.koda-nvim.outPath;
      })
      pkgs.vimPlugins.lush-nvim
      pkgs.vimPlugins.zenbones-nvim
      pkgs.vimPlugins.lackluster-nvim
      pkgs.vimPlugins.poimandres-nvim
      pkgs.vimPlugins.kanso-nvim
    ];
    extraConfigLua = ''
      vim.cmd.colorscheme("koda")
    '';
  };
}
