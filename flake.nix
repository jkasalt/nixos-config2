{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    blueprint = {
      url = "github:numtide/blueprint";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    nvim-flake = {
      url = "github:jkasalt/nvim-flake";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    };

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
  };

  outputs =
    inputs:
    inputs.blueprint {
      inherit inputs;
      systems = [ "x86_64-linux" ];
    };
}
