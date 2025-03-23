_: {
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings.mainBar = {
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
    };
  };
}
