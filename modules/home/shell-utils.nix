_: {
  programs =
    let
      enable = {
        enable = true;
        enableFishIntegration = true;
      };
    in
    {
      broot = enable;
      carapace = enable;
      zoxide = enable;
      starship = enable;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
