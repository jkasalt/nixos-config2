{
  flake.modules.homeManager.syncthing = {
    services.syncthing = {
      enable = true;
      settings = {
        folders = {
          org = {
            path = "~/org";
            id = "ade4h-1hu75";
            devices = ["phone"];
            versioning.type = "staggered";
          };
          main = {
            path = "~/Syncthing";
            id = "jd2fc-ypyfg";
            devices = ["phone"];
            versioning.type = "staggered";
          };
          keepass = {
            path = "~/keepass";
            id = "syxug-6z39p";
            devices = ["phone"];
            versioning.type = "staggered";
          };
          pictures = {
            path = "~/Pictures";
            id = "ubb5d-bi7i2";
            devices = ["phone"];
            versioning.type = "staggered";
          };
          dcim = {
            path = "~/Pictures/DCIM";
            id = "sygqi-agyqu";
            devices = ["phone"];
            versioning.type = "staggered";
          };
          from-work-laptop = {
            path = "~/Syncthing/From-work-laptop";
            id = "i7qwf-tr7uz";
            devices = ["phone"];
            versioning.type = "staggered";
          };
        };
        devices = {
          phone.id = "WOKBM7U-XGRISYG-NCCQEBY-Y676IZZ-R4PJYGW-2EBATRI-NEQXODM-TQPGZA6";
        };
      };
    };
  };
}
