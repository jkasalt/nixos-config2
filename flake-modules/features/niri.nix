{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    security.pam.services.login.enableGnomeKeyring = true;
    environment.systemPackages = [pkgs.nautilus];
    programs.niri.enable = true;
    programs.dms-shell = {
      enable = true;
    };
  };

  flake.modules.homeManager.niri = {
    pkgs,
    lib,
    ...
  }: let
    allowWhenLocked = bind: bind // {allow-when-locked = true;};
  in {
    imports = [inputs.niri.homeModules.niri];
    programs.niri.package = pkgs.niri;
    programs.niri.settings = {
      prefer-no-csd = true;

      spawn-at-startup = [
        {argv = ["fcitx5"];}
      ];

      input = {
        keyboard = {
          xkb = {
            layout = "ch";
            variant = "fr";
            options = "caps:escape";
          };
          repeat-rate = 40;
          repeat-delay = 250;
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot-%Y-%m-%dT%H-%M-%S.png";

      switch-events.lid-close.action.spawn = ["dms" "ipc" "lock" "lock"];

      binds = {
        "Mod+Return".action.spawn = lib.getExe pkgs.kitty;
        "Mod+S".action.spawn = ["dms" "ipc" "launcher" "toggle"];
        "Mod+Shift+E".action.quit = {};
        "Mod+M".action.maximize-column = {};
        "Mod+Shift+H".action.show-hotkey-overlay = {};
        "Mod+Q".action.close-window = {};
        "Mod+L".action.spawn = ["dms" "ipc" "lock" "lock"];

        Print.action.screenshot = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window = {};

        XF86AudioRaiseVolume.action.spawn = ["dms" "ipc" "audio" "increment" "5"];
        XF86AudioLowerVolume.action.spawn = ["dms" "ipc" "audio" "decrement" "5"];
        XF86AudioMute = allowWhenLocked {action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];};
        XF86AudioMicMute = allowWhenLocked {action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];};
        XF86AudioPlay = allowWhenLocked {action.spawn = ["playerctl" "play-pause"];};
        XF86AudioStop = allowWhenLocked {action.spawn = ["playerctl" "stop"];};
        XF86AudioPrev = allowWhenLocked {action.spawn = ["playerctl" "previous"];};
        XF86AudioNext = allowWhenLocked {action.spawn = ["playerctl" "next"];};

        XF86MonBrightnessUp = allowWhenLocked {action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];};
        XF86MonBrightnessDown = allowWhenLocked {action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];};
        # "Mod+Space".action.spawn-sh = let
        #   kbd = "brightnessctl -d tpacpi::kbd_backlight";
        # in "${kbd} set $(( ($(${kbd} get) + 1) % 3 ))";
        # "Mod+Backspace" = noctaliaDo "panel-toggle session";
      };

      layout = {
        gaps = 0;
        center-focused-column = "on-overflow";
        default-column-width.proportion = 0.5;
        focus-ring = {
          width = 1;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
      };
    };
  };
}
