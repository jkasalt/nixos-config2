{
  flake.modules.homeManager.browser = {...}: {
    programs.brave = {
      enable = true;
      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
        {id = "oboonakemofpalcgghocfoadofidjkkk";} # KeePassXC-Browser
        {id = "edibdbjcniadpccecjdfdjjppcpchdlm";} # I Still Don't Care About Cookies
        {id = "likgccmbimhjbgkjambclfkhldnlhbnn";} # Yomitan
        {id = "hkledmpjpaehamkiehglnbelcpdflcab";} # asbplayer
      ];
    };

    programs.nyxt.enable = true;
  };
}
