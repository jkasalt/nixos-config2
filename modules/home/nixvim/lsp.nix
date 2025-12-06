{ config, ... }:
let
  helpers = config.lib.nixvim;
in
{
  programs.nixvim = {
    lsp = {
      inlayHints.enable = true;
      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gr";
          lspBufAction = "references";
        }
        {
          key = "ga";
          lspBufAction = "code_action";
        }
        {
          key = "gt";
          lspBufAction = "type_definition";
        }
        {
          key = "gi";
          lspBufAction = "implementation";
        }
        {
          action = helpers.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
          key = "<leader>k";
        }
        {
          action = helpers.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
          key = "<leader>j";
        }
        {
          action = helpers.mkRaw "require('telescope.builtin').lsp_definitions";
          key = "gd";
        }
      ];
    };
    diagnostic.settings = {
      virtual_lines.current_line = true;
    };
    plugins.lspconfig.enable = true;
    plugins.fidget.enable = true;
  };
}
