{pkgs, ...}: {
  programs.nixvim.lsp.servers.gleam.enable = true;

  home.packages = [pkgs.gleam];
}
