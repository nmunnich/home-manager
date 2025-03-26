{ config, pkgs, ... }:
let
  mod = "Mod4";
  bg = " #40291a";
  bg-inactive = " #323232";
  bg-urgent = " #000000";
  text = " #eeeeec";
  text-inactive = " #babdb6";
  bar = " #323232";
  statusline = " #e0e0e0";
  tf-color = " #fcbafc";
  nf-color = " #d62fd6";
  hf-color = " #ff00ff";
  hb-color = " #660066";
in {
  imports = [
    # Import a module from the Home Manager repository
    ./waybar.nix
  ];

  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      width = 250;
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = {
      colors = {
        focused = {
          border = bg;
          background = bg;
          text = text;
          indicator = bg;
          childBorder = bg;
        };
        unfocused = {
          border = bg-inactive;
          background = bg-inactive;
          text = text-inactive;
          indicator = bar;
          childBorder = bar;
        };
        focusedInactive = {
          border = bg-inactive;
          background = bg-inactive;
          text = text-inactive;
          indicator = bar;
          childBorder = bar;
        };
        urgent = {
          border = bg-urgent;
          background = bg-urgent;
          text = text;
          indicator = bar;
          childBorder = bar;
        };
      };
      window = {
        border = 0;
        commands = [
          {
            command = "opacity 1";
            criteria = { class = "vivaldi-stable"; };
          }
          {
            command = "border pixel 0";
            criteria = { class = ".*"; };
          }
          {
            command = "inhibit_idle fullscreen";
            criteria = { app_id = ".*"; };
          }
        ];
      };
      gaps.inner = 8;
      modifier = mod;
      terminal = "alacritty";
      menu =
        "bemenu-run -i --tf ${tf-color} --nf ${nf-color} --hf ${hf-color} --hb ${hb-color} -n -m -1";
      output = {
        "*" = { bg = "/home/nick/Pictures/Wallpapers/neon-city-sky.jpg fill"; };
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us,de";
          xkb_variant = ",nodeadkeys";
          xkb_options = "grp:toggle";
        };
      };
      mode = {
        resize = {
          Down = "resize grow height 10 px";
          Escape = "mode default";
          Left = "resize shrink width 10 px";
          Return = "mode default";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          h = "resize shrink width 10 px";
          j = "resize grow height 10 px";
          k = "resize shrink height 10 px";
          l = "resize grow width 10 px";
        };
      };
      keybindings = lib.attrsets.mergeAttrsList [
        (lib.attrsets.mergeAttrsList (map (num:
          let ws = toString num;
          in {
            "${mod}+${ws}" = "workspace ${ws}";
            "${mod}+Shift+${ws}" = "move container to workspace ${ws}";
          }) [ 1 2 3 4 5 6 7 8 9 0 ]))

        (lib.attrsets.concatMapAttrs (key: direction: {
          "${mod}+${key}" = "focus ${direction}";
          "${mod}+Shift+${key}" = "move ${direction}";
        }) {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          Left = "left";
          Down = "down";
          Up = "up";
          Right = "right";
        })

        {
          "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+Shift+space" = "floating toggle";

          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "scratchpad show";

          "${mod}+d" = "exec ${pkgs.bemenu}/bin/bemenu-run -i";
          "${mod}+a" = "focus parent";
          "${mod}+e" = "layout toggle split";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+b" = "split h";
          "${mod}+s" = "layout stacking";
          "${mod}+v" = "split v";
          "${mod}+w" = "layout tabbed";
          "${mod}+r" = "mode resize";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
        }
      ];
      focus.followMouse = false;
      startup = [{ command = "firefox"; }];
      workspaceAutoBackAndForth = true;
    };
    systemd.enable = true;
    wrapperFeatures = { gtk = true; };
  };

  programs = {
    swaylock = {
      enable = true;
      settings = {
        color = "808080";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        line-color = "ffffff";
        show-failed-attempts = true;
      };
    }; # lock screen
    #swayr = { enable = true; };
    #swayimg = { enable = true; };
  };
  security.pam.services.swaylock = { };
  services = {
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 900;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
    swaync = { enable = true; }; # notifications
    #swayosd = { enable = true; };
  };

  # home.file.".hm-graphical-session".text = pkgs.lib.concatStringsSep "\n" [
  #   "export MOZ_ENABLE_WAYLAND=1"
  #   "export NIXOS_OZONE_WL=1" # Electron
  # ];

  # services.cliphist.enable = true;

  # services.kanshi = {
  #   enable = true;
  # };
  # home.pointerCursor.sway.enable = true;
  home.packages = with pkgs; [ grim slurp wl-clipboard ];
}

# home-manager/option/wayland.windowManager.sway.config
# Sway configuration options
# Score: 100%
# home-manager/option/wayland.windowManager.sway.enable
# Whether to enable sway wayland compositor
# Score: 100%
# home-manager/option/wayland.windowManager.sway.package
# Sway package to use
# Score: 100%
# home-manager/option/wayland.windowManager.sway.systemd.enable
# Whether to enable sway-session.target on sway startup
# Score: 100%
# home-manager/option/wayland.windowManager.sway.swaynag.enable
# Whether to enable configuration of swaynag, a lightweight error bar for sway
# Score: 100%
# home-manager/option/wayland.windowManager.sway.wrapperFeatures
# Attribute set of features to enable in the wrapper
# Score: 100%
# home-manager/option/wayland.windowManager.sway.extraConfigEarly
# Like extraConfig, except lines are added to ~/.config/sway/config before all other configuration
# Score: 100%
# home-manager/option/wayland.windowManager.sway.swaynag.settings
# Configuration written to $XDG_CONFIG_HOME/swaynag/config
# Score: 100%
# home-manager/option/wayland.windowManager.sway.systemd.variables
# Environment variables imported into the systemd and D-Bus user environment
# Score: 100%
# home-manager/option/wayland.windowManager.sway.wrapperFeatures.gtk
# Whether to make use of the wrapGAppsHook wrapper to execute sway with required environment variabl…
# Score: 100%
# home-manager/option/wayland.windowManager.sway.wrapperFeatures.base
# Whether to make use of the base wrapper to execute extra session commands and prepend a dbus-run-s…
# Score: 100%
# home-manager/option/wayland.windowManager.sway.extraSessionCommands
# Shell commands executed just before Sway is started
# Score: 100%
# home-manager/option/wayland.windowManager.sway.systemd.xdgAutostart
# Whether to enable autostart of applications using systemd-xdg-autostart-generator(8)
# Score: 100%
# home-manager/option/wayland.windowManager.sway.systemd.extraCommands
# Extra commands to run after D-Bus activation
# Score: 100%
