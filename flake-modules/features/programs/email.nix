{
  flake.modules.homeManager.email = {pkgs, ...}: {
    accounts.email.accounts.ik = {
      address = "luca.bracone@ik.me";
      realName = "Luca Bracone";
      userName = "luca.bracone@ik.me";
      primary = true;

      imap = {
        host = "mail.infomaniak.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "mail.infomaniak.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      # Requires KeePassXC secret service enabled. On the Infomaniak mail entry,
      # add a custom attribute "type" = "imap" to disambiguate from other entries
      # that share the same username.
      passwordCommand = "secret-tool lookup username luca.bracone@ik.me type imap";

      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        patterns = ["*"];
      };

      msmtp.enable = true;
      mu.enable = true;
    };

    programs.mbsync.enable = true;
    programs.msmtp.enable = true;
    programs.mu.enable = true;

    home.packages = with pkgs; [libsecret]; # provides secret-tool
  };
}
