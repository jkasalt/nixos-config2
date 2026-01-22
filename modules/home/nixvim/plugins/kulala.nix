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
  };
}
