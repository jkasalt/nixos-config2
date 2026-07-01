{
  flake.nixosModules.niri =
    {pkgs, ...}:
    {
      security.pam.services.login.enableGnomeKeyring = true;
      environment.systemPackages = [pkgs.nautilus];
      programs.niri.enable = true;
    };
}
