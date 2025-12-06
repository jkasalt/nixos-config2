_: {
  programs.nixvim.plugins = {
    fugitive.enable = true;
    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
      };
    };
  };
}
