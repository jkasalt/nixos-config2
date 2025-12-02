{
  pkgs,
  inputs,
  ...
}:
let
  treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs {
    programs.nixfmt.enable = true;
    settings.formatter.nixfmt.excludes = [ "hardware-configuration.nix" ];
  };
in
treefmtEval.config.build.wrapper
