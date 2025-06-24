{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ nil ];
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        cursorline = true;
        bufferline = "multiple";
        color-modes = true;
        end-of-line-diagnostics = "hint";
        lsp = {
          display-progress-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        soft-wrap.enable = true;
        indent-guides.render = true;
        inline-diagnostics = {
          cursor-line = "hint";
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
    ];
  };
}
