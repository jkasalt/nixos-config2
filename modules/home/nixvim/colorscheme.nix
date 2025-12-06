{inputs, pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "oasis.nvim";
        src = inputs.oasis-nvim.outPath;
      })
    ];
    extraConfigLua = ''
      require("oasis").setup()
      vim.cmd.colorscheme("oasis-midnight")
    '';
  };
}
