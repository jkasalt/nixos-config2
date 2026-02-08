{ pkgs, ... }:
{
  home.packages = [ pkgs.taskwarrior3 ];
  imports = [ ./shell.nix ];

  home.file.".config/task/taskrc".text = ''
    urgency.user.tag.in.coefficient=15.0
    report.in.columns           = id,description
    report.in.description       = Inbox
    report.in.filter            = status:pending limit:page (+in)
    report.in.labels            = ID,Description
  '';

  shell.shellAliases = {
    tin = "task add +in";
  };
}
