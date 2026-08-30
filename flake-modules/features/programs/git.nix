{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.git = {...}: {
    programs.difftastic = {
      enable = true;
      git.enable = true;
    };
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "lucabr123@gmail.com";
          name = "Luca Bracone";
        };
        branch.sort = "-committerdate";
        column.ui = "auto";
        alias = let
          log = "log --show-notes='*' --abbrev-commit --pretty=format:'%Cred%h %Cgreen(%aD)%Creset -%C(bold red)%d%Creset %s %C(bold blue)<%an>% %Creset' --graph";
        in {
          a = "add --patch"; # make it a habit to consciosly add hunks
          ad = "add";

          b = "branch";
          ba = "branch -a"; # list remote branches
          bd = "branch --delete";
          bdd = "branch -D";

          c = "commit";
          ca = "commit --amend";
          cm = "commit --message";

          cl = "clone";

          d = "diff";
          ds = "diff --staged";

          h0 = "show";
          h1 = "show HEAD^";
          h2 = "show HEAD^^";
          h3 = "show HEAD^^^";
          h4 = "show HEAD^^^^";
          h5 = "show HEAD^^^^^";

          m = "merge";
          ma = "merge --abort";
          mc = "merge --continue";

          p = "push";
          pf = "push --force-with-lease";

          pl = "pull";

          l = log;
          lp = "${log} --patch";
          la = "${log} --all";

          rs = "restore";
          rsp = ''
            !f() { git restore --source="$1" --patch "$2"; }; f;
          '';
          rsh = "reset --hard";

          sw = "switch";
          sc = "switch -c";

          s = "status --short --branch";
          ss = "status";

          st = "stash";
          stc = "stash clear";
          sth = "stash show --patch";
          stl = "stash list";
          stp = "stash pop";

          forgor = "commit --amend --no-edit";
          oops = "restore";
        };
        diff = {
          colorMoved = "default";
          algorithm = "histogram";
          renames = "copies";
        };
        merge.conflictStyle = "diff3";
        rerere.enabled = true;
        pull.rebase = true;
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
    };
  };
}
