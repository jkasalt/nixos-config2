{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim.enable = true;
  programs.nixvim.colorscheme = "catppuccin";
}
