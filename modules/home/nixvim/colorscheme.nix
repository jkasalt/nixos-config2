{inputs, pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "oasis.nvim";
        src = inputs.oasis-nvim.outPath;
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "sarnai.nvim";
        src = inputs.sarnai-nvim.outPath;
      })
      pkgs.vimPlugins.lush-nvim
      pkgs.vimPlugins.zenbones-nvim
      pkgs.vimPlugins.lackluster-nvim
      pkgs.vimPlugins.poimandres-nvim
    ];
    extraConfigLua = ''
      vim.cmd.colorscheme("lackluster")
    '';
  };
}
