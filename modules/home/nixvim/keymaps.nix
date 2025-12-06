_: {
  programs.nixvim.keymaps = [
    {
      action = ":bn<CR>";
      key = "L";
      options.silent = true;
    }
    {
      action = ":bp<CR>";
      key = "H";
      options.silent = true;
    }
  ];
}
