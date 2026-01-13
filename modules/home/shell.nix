{ pkgs, lib, config, ... }:
with lib;
let cfg = config.shell; in
{
  options.shell = {
    shellAliases = mkOption {
      type = with types; attrsOf str;
    };
  };

  config = {
    programs.fish = {
      enable = true;
      inherit (cfg) shellAliases;
    };
  };
}
