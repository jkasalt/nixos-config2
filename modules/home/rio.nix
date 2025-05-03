{ pkgs, lib, ... }:
{
  programs.rio = {
    enable = true;
    settings = {
      cursor.blinking = true;
    };
  };

}
