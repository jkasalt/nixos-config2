{lib, ...}: {
  programs.nixvim = {
    plugins.web-devicons.enable = true;
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
        frecency.enable = true;
      };
    };
    keymaps =
      let
        mkKeymap = key: action: {
          inherit key;
          action = lib.strings.concatStrings ["<CMD>Telescope " action "<CR>"];
          mode = "n";
          options = {
            silent = true;
            noremap = true;
          };
        };
      in
      [
        (mkKeymap "ff" "find_files")
        (mkKeymap "fg" "live_grep")
        (mkKeymap "fb" "buffers")
      ];
  };

}
