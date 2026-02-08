{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kulala-nvim = {
      url = "github:mistweaverco/kulala.nvim";
      flake = false;
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oasis-nvim = {
      url = "github:uhs-robert/oasis.nvim";
      flake = false;
    };

    koda-nvim = {
      url = "github:oskarnurm/koda.nvim";
      flake = false;
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      stylix,
      home-manager,
      zen-browser,
      niri,
      noctalia,
      nixvim,
      oasis-nvim,
      koda-nvim,
      treefmt-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        config = { };
        overlays = [ ];
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        juugas = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/juugas/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.lucab = ./hosts/juugas/users/lucab/home-configuration.nix;
                backupFileExtension = "bak";
                sharedModules = [
                  noctalia.homeModules.default
                  nixvim.homeModules.nixvim
                  zen-browser.homeModules.beta
                ];
              };
            }
            { nixpkgs.overlays = [ niri.overlays.niri ]; }
            { nixpkgs.overlays = [ self.overlays.default ]; }
            niri.nixosModules.niri
            stylix.nixosModules.stylix
          ];
        };
      };
      formatter.${system} = pkgs.callPackage ./formatter.nix { inherit treefmt-nix; };
      overlays.default = final: prev: {
        vimPlugins = prev.vimPlugins or {} // {
          oasis-nvim = prev.vimUtils.buildVimPlugin {
            name = "oasis.nvim";
            src = oasis-nvim.outPath;
          };
          koda-nvim = prev.vimUtils.buildVimPlugin {
            name = "koda.nvim";
            src = koda-nvim.outPath;
          };
        };
      };
    };
}
