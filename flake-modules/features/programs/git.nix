{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.git = {...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "lucabr123@gmail.com";
          name = "Luca Bracone";
        };
        branch.sort = "-committerdate";
        column.ui = "auto";
      };
    };
  };
}
