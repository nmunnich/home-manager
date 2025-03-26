{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    config = {

      layer = "top"; # Waybar at top layer
      position = "top"; # Waybar at the top of your screen
      height = 24; # Waybar height
      width = 1366; # Waybar width
      # Choose the order of the modules
      modules-center = [ "sway/window" ];
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-right = [
        "tray"
        "pulseaudio"
        "idle_inhibitor"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
      ];
      "sway/workspaces" = {
        all-outputs = false;
        disable-scroll = false;
        format = "{icon}";
        format-icons = {
          "10: VapourSynth" = "";
          "1: Terminal" = "";
          "2: Messengers" = "";
          "3: Browser" = "";
          "4: Games" = "";
          "5: LaTeX" = "";
          "6: KeePass" = "";
          "7: Video" = "";
          "8: Code" = "";
          "9: Tor" = "";
          default = "";
          focused = "";
          urgent = "";
        };
      };
      "sway/mode" = { format = ''<span style="italic">{}</span>''; };

      tray = {
        spacing = 10;
        # icon-size = 21;
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        timeout = 30.5;
      };
      memory = { format = "{}% "; };
      backlight = {
        format = "{percent}% {icon}";
        format-icons = [ "" ];
      };
      battery = {
        bat = "BAT0";
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        # format-good = "", # An empty format will hide the module
        # format-full = "",
        states = {
          critical = 23;
          warning = 35;
          # good = 95;
        };
      };
      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%Y-%m-%d}";
      };
      cpu = { format = "{usage}% "; };
      network = {
        # interface = "wlp2s0";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ipaddr}/{cidr} ";
        format-wifi = "({signalStrength}%) ";
        on-click = "nm-connection-editor";
      };
      pulseaudio = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-icons = {
          car = "";
          default = [ "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = "";
        on-click = "pavucontrol";
        scroll-step = 1;
      };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ " " " " " " ];
        thermal-zone = 6;
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "FontAwesome", "Ubuntu Nerd Font";
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
        /* background-color: rgba(18, 21, 29, 0.98); */
        background-color: rgba(7,8,11,0.5);
        /* background-color: rgba(0, 0, 0, 0); */
        border-bottom: 3px solid #1e222a;
        color: #abb2bf;
        transition-property: background-color;
        transition-duration: .5s;

      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #window {
          font-weight: bold;
          font-family: "Ubuntu";
      }

      /*
      #workspaces {
          padding: 0 5px;
      }
      */

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          border-top: 2px solid transparent;
          min-width: 20px;
          color: #6392fc;
      }

      #workspaces button:hover {
        background-color: rgba(0, 0, 0, 0.2)
      }

      #workspaces button.focused {
        color: #da67ed;
      }

      #workspaces button.urgent {
        color: #e06c75;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock, #idle_inhibitor, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
          padding: 0 3px;
          margin: 0 2px;
      }

      #pulseaudio, #network{
        color: #da67ed;
      }

      #clock, #cpu, #memory {
        color: #6392fc;
      }

      #clock {
          font-weight: bold;
      }

      #idle_inhibitor.activated{
          color: #7dcd4b;
      }

      #battery {
        color: #7dcd4b;
      }

      #battery icon {
          color: red;
      }

      #battery.charging, #battery.plugged {
        color: #7dcd4b;
      }

      @keyframes blink {
          to {
              background-color: #9fdfff;
              color: #f20231;
          }
      }

      #battery.critical:not(.charging) {
          color: #e06c75;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #temperature {
        color: #7dcd4b;
      }

      #temperature.critical {
        color: #e06c75;
      }

      #network.disconnected {
          color: #e06c75;
      }

      #pulseaudio.muted {
        color: #e06c75;
      }

      #tray {
        background-color: #1e222a;
        padding: 0 10px;
        margin: 2px 4px 5px 4px;
        border: 3px solid rgba(0, 0, 0, 0);
        border-radius: 90px;
        background-clip: padding-box;
      }

      #tray > .active{
        color: #abb2bf;
      }'';
  };
}
