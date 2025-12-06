{ inputs, pkgs, ... }:
let
  kulala-http-grammar = pkgs.tree-sitter.buildGrammar {
    language = "kulala_http";
    version = "5.3.1";
    src = inputs.kulala-nvim.outPath;
    location = "lua/tree-sitter";
  };
in
{
  programs.nixvim.plugins = {
    kulala = {
      enable = true;
      lazyLoad.settings.ft = "http";
      settings = {
        global_keymaps = true;
      };
    };

    treesitter = {
      enable = true;
      grammarPackages = [ kulala-http-grammar ];
      luaConfig.post = # lua
        ''
          do
          local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
          -- change the following as needed
          parser_config.kulala_http = {
            install_info = {
              url = "${kulala-http-grammar}",
              files = {"src/parser.c"},
            },
            filetype = "kulala_http",
          }
          end
        '';
    };
  };
}
