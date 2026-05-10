{ inputs, ... }:

{
  imports = [
    inputs.hm-wrapper-modules.flakeModules.default
    inputs.flake-parts.flakeModules.modules
  ];

  hmWrappers = {
    inherit (inputs) home-manager;
    autoWrap = true;
  };
}
