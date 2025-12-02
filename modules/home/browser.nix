{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".beta
  ];
}
