{
  flake.modules.homeManager.passwords = {
    config,
    lib,
    ...
  }: {
    # Real ssh-agent for KeePassXC's SSH Agent integration to feed key
    # passphrases into (on Linux it's a client of SSH_AUTH_SOCK, not its
    # own listener). Also wires up SSH_AUTH_SOCK for the shell.
    services.ssh-agent.enable = true;

    programs.keepassxc = {
      enable = true;

      settings = {
        FdoSecrets.Enabled = true;
        Browser.Enabled = true;
        SSHAgent = {
          Enabled = true;
          UseOpenSSH = true;
        };
        GUI = {
          ShowTrayIcon = true;
          MinimizeOnClose = true;
        };
      };
    };

    # keepassxc.ini is a read-only Nix store symlink, so KeePassXC can never
    # persist a "last opened database" to it -- the generic XDG autostart
    # entry (bare `keepassxc`, no args) would launch with nothing open, and
    # anything asking it to unlock over D-Bus (e.g. secret-tool, via the
    # FdoSecrets integration above) would fail with "no filepath was
    # provided" since there's no database tab to unlock. Launch with the
    # database path directly instead.
    systemd.user.services.keepassxc = {
      Unit = {
        Description = "KeePassXC";
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${lib.getExe config.programs.keepassxc.package} ${config.home.homeDirectory}/keepass/passwords.kdbx";
        Restart = "on-failure";
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
