_: {
  systemd = {
    services.scheduled-shutdown = {
      description = "Scheduled shutdown";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = [ "/run/current-system/sw/bin/sh" "-c" "systemctl poweroff" ];
      };
    };

    timers.scheduled-shutdown = {
      description = "Timer for scheduled shutdown";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "22:00";
        Persistent = true;
      };
    };
  };
}
