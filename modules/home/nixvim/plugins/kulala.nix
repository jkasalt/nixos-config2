_: {
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
