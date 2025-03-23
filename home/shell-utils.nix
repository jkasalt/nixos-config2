_: {
  programs =
    let
      enable = {
        enable = true;
        enableNushellIntegration = true;
      };
    in
    {
      broot = enable;
      carapace = enable;
      zoxide = enable;
      starship = enable;
      direnv = enable // {
        nix-direnv.enable = true;
      };
    };
}
