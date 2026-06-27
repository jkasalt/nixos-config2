{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    beancount-import-def = {
      python3Packages,
      fetchPypi,
    }:
      python3Packages.buildPythonApplication (finalAttrs: {
        pname = "beancount-import";
        version = "1.4.0";
        src = fetchPypi {
          inherit (finalAttrs) pname version;
          hash = "";
        };
      });
  in {
    packages.beancount-import = pkgs.callPackage beancount-import-def {};
  };
  flake = {
    homeModules.beancount = {
      pkgs,
      inputs,
      ...
    }: {
      home.packages = with pkgs; [
        beancount
        fava
        self'.packages.beancount-import
      ];
    };
  };
}
