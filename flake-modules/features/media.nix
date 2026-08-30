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
        inputs'.curd.packages.default
        pkgs.qbittorrent
        pkgs.zathura
      ];

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
