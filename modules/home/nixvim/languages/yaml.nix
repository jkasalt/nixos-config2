_: {
  programs.nixvim = {
    lsp.servers = {
      helm_ls.enable = true;
      yamlls.enable = true;
    };
    plugins.schemastore = {
      enable = true;
      json.enable = false;
    };
  };
}
