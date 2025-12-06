_: {
  programs.nixvim.plugins.lspconfig.enable = true;

  imports = [
    ./nix.nix
    ./rust.nix
    ./haskell.nix
    # ./gleam.nix
    # ./ocaml.nix
    # ./yaml.nix
    # ./python.nix
  ];
}
