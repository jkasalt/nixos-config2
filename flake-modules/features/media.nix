{moduleWithSystem, ...}: {
  perSystem = {pkgs, ...}: {
    packages.mpv = pkgs.mpv.override {
      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
      ];

      mpv-unwrapped = pkgs.mpv-unwrapped.override {waylandSupport = true;};
    };
  };
  flake.modules.homeManager.media = moduleWithSystem (
    {
      inputs',
      self',
      ...
    }: {pkgs, ...}: {
      home.packages = [
        pkgs.qbittorrent-enhanced
      ];

      programs.zathura.enable = true;

      programs.mpv = {
        enable = true;

        package = self'.packages.mpv;

        config = {
          profile = "high-quality";
          ytdl-format = "bestvideo+bestaudio";
          cache-default = 4000000;
        };
      };
    }
  );
}
