{ pkgs, inputs, ... }:
let
  sarnaiTheme = pkgs.writeText "sarnai.yaml" ''
    system: "base16"
    name: "Sarnai"
    slug: "sarnai"
    author: "titembataar"
    description: "🌸 sarnai - A Mongolian-inspired colorscheme for neovim"
    variant: "dark"
    palette:
      base00: "#172620"
      base01: "#31413b"
      base02: "#4e5d58"
      base03: "#6d7b77"
      base04: "#8d9a97"
      base05: "#aebbb8"
      base06: "#d1dcdb"
      base07: "#f5fffe"
      base08: "#ff6b6b"
      base09: "#e5951a"
      base0A: "#e0b255"
      base0B: "#80b946"
      base0C: "#9deaea"
      base0D: "#2b879e"
      base0E: "#d5b3e5"
      base0F: "#f0c3cb"
  '';
in
{
  stylix = {
    enable = true;
    base16Scheme = "${sarnaiTheme}";
    image = ./wallpapers/nix-wallpaper-nineish-dark-gray.png;

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        name = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
      };
      monospace = {
        # package = pkgs.nerd-fonts.blex-mono;
        # name = "BlexMono Nerd Font Mono";
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
    };
  };
}
