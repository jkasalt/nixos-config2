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
    {
      action = "<ESC>";
      key = "jk";
      mode = ["i"];
      options.silent = true;
    }
  ];
}
