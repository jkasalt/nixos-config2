{ inputs, pkgs, ... }:
inputs.pre-commit-hooks.lib.${pkgs.system}.run {
  src = ./.;
  hooks = {
    nixpkgs-fmt.enable = true;
  };
}
