{ pkgs, ... }:
{
  # for some reason, adding maestral-gui to the list of packages does not
  # actually let us run the GUI
  home.packages = with pkgs; [ maestral maestral-gui ];
}
