{moduleWithSystem, ...}: {
  flake.modules.homeManager.beancount = moduleWithSystem (
    {inputs', ...}: {pkgs, ...}: {
      home.packages = with pkgs; [
        beancount
        fava
        inputs'.rustledger.packages.rustledger
      ];
    }
  );
}
