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
    ];
    extraConfigLua = ''
      require("oasis").setup()
      vim.cmd.colorscheme("oasis-midnight")
    '';
  };
}
