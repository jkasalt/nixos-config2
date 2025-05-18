{ pkgs, ... }:
{
  home.packages = with pkgs; [htop];
  programs = {
    zk = {
      enable = true;
      settings = {
        notebook.dir = "~/notebook";
      };
    };

    mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            uosc
            sponsorblock
          ];

          mpv = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
          };
        }
      );

      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo+bestaudio";
        cache-default = 4000000;
        gpu-context = "wayland";

      };
    };

    gitui = {
      enable = true;
      keyConfig = # ron
        ''
	(
	  move_left: Some(( code: Char('h'), modifiers: "")),
	  move_right: Some(( code: Char('l'), modifiers: "")),
	  move_up: Some(( code: Char('k'), modifiers: "")),
	  move_down: Some(( code: Char('j'), modifiers: "")),

	  stash_open: Some(( code: Char('l'), modifiers: "")),
	  open_help: Some(( code: F(1), modifiers: "")),

	  status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),
	)
        '';
    };
  };
}
