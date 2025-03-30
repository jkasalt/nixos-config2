_: {
  programs.waybar = {
    enable = false;
    style = ./style.css;
    settings.mainBar = {
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
    };
  };
}
