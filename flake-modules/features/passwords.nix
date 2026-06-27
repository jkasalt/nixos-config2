{
  flake.modules.homeManager.passwords =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ keepassxc ];
    };
}
