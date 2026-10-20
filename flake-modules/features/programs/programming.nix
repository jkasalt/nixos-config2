{
  flake.modules.homeManager = {

  ocaml = {pkgs, ...}: {
    programs.opam = {
      enable = true;
      enableZshIntegration = true;
    };
    home.packages = with pkgs; [
      dune
      gnumake
    ];
  };

  odin = {pkgs, ...}: {
    home.packages = with pkgs; [clang odin];
  };
};
}
