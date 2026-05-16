{
  withSystem,
  inputs,
  ...
}:
{
  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      ...
    }:
    {
      security = {
        polkit.enable = true;
        pam.services.login.enableGnomeKeyring = true;
      };
      services.gnome.gnome-keyring.enable = true;
      programs.niri = {
        enable = true;
        package = withSystem pkgs.stdenv.hostPlatform.system ({ self', ... }: self'.packages.niri);
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.noctaliaShell = pkgs.noctalia-shell;

      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings =
          let
            noctaliaBin = lib.getExe self'.packages.noctaliaShell;
            bash = lib.getExe pkgs.bash;
            allowWhenLocked =
              thing: _:
              (thing { })
              // {
                props.allow-when-locked = true;
              };
            spawn = spawn-sh: _: { content.spawn = lib.splitString " " spawn-sh; };
            do = action: _: { content.${action} = _: { }; };
            noctaliaDo = command: _: {
              content.spawn = lib.splitString " " "${noctaliaBin} ipc call ${command}";
            };
          in
          {
            prefer-no-csd = _: { };
            spawn-at-startup = [ noctaliaBin ];

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
                tap = _: { };
                natural-scroll = _: { };
              };
            };

            binds = {
              "Mod+Return".spawn = lib.getExe pkgs.kitty;
              "Mod+S" = noctaliaDo "launcher toggle";
              "Mod+Shift+E" = do "quit";
              "Mod+M" = do "maximize-window-to-edges";
              "Mod+Shift+H" = do "show-hotkey-overlay";
              "Mod+Q" = do "close-window";

              XF86AudioRaiseVolume = allowWhenLocked (noctaliaDo "volume increase");
              XF86AudioLowerVolume = allowWhenLocked (spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-");
              XF86AudioMute = allowWhenLocked (spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle");
              XF86AudioMicMute = allowWhenLocked (spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle");
              XF86AudioPlay = allowWhenLocked (spawn "playerctl play-pause");
              XF86AudioStop = allowWhenLocked (spawn "playerctl stop");
              XF86AudioPrev = allowWhenLocked (spawn "playerctl previous");
              XF86AudioNext = allowWhenLocked (spawn "playerctl next");

              XF86MonBrightnessUp = allowWhenLocked (spawn "brightnessctl --class=backlight set +10%");
              XF86MonBrightnessDown = allowWhenLocked (spawn "brightnessctl --class=backlight set 10%-");
              "Mod+Space" =
                let
                  kbd_light = "brightnessctl -d tpacpi::kbd_backlight";
                in
                {
                  spawn-sh = "${bash} -c ${kbd_light} set $(( ($(${kbd_light} get) + 1) % 3 ))";
                };
            };

            layout = {
              gaps = 0;
              center-focused-column = "on-overflow";
              default-column-width.proportion = 0.5;
              focus-ring = {
                width = 1;
                active-color = "#7fc8ff";
                inactive-color = "#505050";
              };
            };
          };
      };
    };
}
