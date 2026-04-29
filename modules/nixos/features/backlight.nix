{ ... }:
{
  flake.nixosModules.backlight =
    { pkgs, ... }:

    let
      inactivityTimeout = 30;

      backlightScript = pkgs.writeShellScript "kbd-backlight-watch" ''
        #!/usr/bin/env bash
        set -euo pipefail

        TIMEOUT=${toString inactivityTimeout}

        STATE_FILE=$(mktemp /tmp/kbd-backlight-state.XXXXXX)
        TIME_FILE=$(mktemp /tmp/kbd-backlight-time.XXXXXX)
        echo "1" > "$STATE_FILE"
        date +%s > "$TIME_FILE"

        cleanup() {
          echo "Cleaning up..."
          kill "''${WATCHDOG_PID:-}" 2>/dev/null || true
          kill "''${EVTEST_PIDS[@]:-}" 2>/dev/null || true
          rm -f "$STATE_FILE" "$TIME_FILE" "$FIFO"
          exit 0
        }
        trap cleanup EXIT INT TERM

        turn_on() {
          if [ "$(cat "$STATE_FILE")" -eq 0 ]; then
            echo "1" > "$STATE_FILE"
            ${pkgs.brightnessctl}/bin/brightnessctl -d platform::kbd_backlight set 100% -q
            echo "Backlight ON"
          fi
        }

        turn_off() {
          if [ "$(cat "$STATE_FILE")" -eq 1 ]; then
            echo "0" > "$STATE_FILE"
            ${pkgs.brightnessctl}/bin/brightnessctl -d platform::kbd_backlight set 0 -q
            echo "Backlight OFF"
          fi
        }

        get_devices() {
          ${pkgs.gawk}/bin/awk '
            /Handlers=/ && (/kbd/ || /mouse/) {
              match($0, /event[0-9]+/, a)
              if (a[0] != "") print "/dev/input/" a[0]
            }
          ' /proc/bus/input/devices
        }

        watchdog() {
          while true; do
            sleep 5
            LAST=$(cat "$TIME_FILE")
            NOW=$(date +%s)
            ELAPSED=$(( NOW - LAST ))
            if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
              turn_off
            fi
          done
        }

        mapfile -t DEVICES < <(get_devices)

        if [ "''${#DEVICES[@]}" -eq 0 ]; then
          echo "No input devices found, exiting"
          exit 1
        fi

        echo "Monitoring ''${#DEVICES[@]} devices:"
        printf '  %s\n' "''${DEVICES[@]}"

        FIFO=$(mktemp -u /tmp/kbd-backlight-fifo.XXXXXX)
        mkfifo "$FIFO"

        EVTEST_PIDS=()
        for dev in "''${DEVICES[@]}"; do
          ${pkgs.evtest}/bin/evtest "$dev" >> "$FIFO" 2>/dev/null &
          EVTEST_PIDS+=($!)
          echo "Watching $dev (pid $!)"
        done

        watchdog &
        WATCHDOG_PID=$!

        while IFS= read -r line < "$FIFO"; do
          if echo "$line" | grep -q "EV_KEY\|EV_REL\|EV_ABS"; then
            date +%s > "$TIME_FILE"
            turn_on
          fi
        done
      '';

    in
    {
      environment.systemPackages = [
        pkgs.brightnessctl
        pkgs.evtest
        pkgs.gawk
      ];

      services.udev.extraRules = ''
        KERNEL=="event*", SUBSYSTEM=="input", GROUP="input", MODE="0660"
      '';

      systemd.services.kbd-backlight-watch = {
        description = "Turn off keyboard backlight on inactivity";
        wantedBy = [ "multi-user.target" ];
        after = [ "systemd-udevd.service" ];

        serviceConfig = {
          ExecStart = "${backlightScript}";
          Restart = "always";
          RestartSec = "5s";
          User = "root";
          StandardOutput = "journal";
          StandardError = "journal";
          SyslogIdentifier = "kbd-backlight";
        };
      };
    };
}
