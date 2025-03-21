{ config, pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    yay = "paru";
    # TODO: make direnv
    zmk-work =
      "cd ~/Documents/Projects/Keyboards/zmk && source ./.venv/bin/activate";
    prettier-zmk = "npm run prettier:format && npm run lint && npm run build";
  };

  # TODO: sway should be managed by home-manager, not via this.
  initSway = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
    fi
  '';

in {
  imports = [
    # Shell theming
    ./oh-my-posh.nix
  ];

  # Extra packages
  home.packages = with pkgs; [ direnv nix-direnv zsh-autosuggestions ];

  programs = {
    direnv.enable = true;
    direnv.enableZshIntegration = true;
    direnv.enableFishIntegration = true;
    direnv.nix-direnv.enable = true;
    command-not-found.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      # Causes this to replace cd
      options = [ "--cmd cd" ];
    };

    ## FISH STUFF
    # Bash only used as a login terminal, autostarts fish when new terminal is opened
    bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
      profileExtra = initSway;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellAbbrs = myAliases;
      plugins = [
        # colorized command output
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        # long command finish notifications
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        # nice bash in fish
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
        # nicer git commands
        {
          name = "forgit";
          src = pkgs.fishPlugins.forgit.src;
        }
        # no shell typos in history
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge.src;
        }
      ];
    };

    # ZSH STUFF
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
      profileExtra = initSway;
      history.size = 10000;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "thefuck"
          "alias-finder"
          "extract"
          "history-substring-search"
          "command-not-found"
          "pass"
        ];
      };

      # TODO: fill this out properly during migration
      dirHashes = {
        doc = "$HOME/Documents";
        pic = "$HOME/Pictures";
        dl = "$HOME/Downloads";
        keebs = "$HOME/Documents/Projects/Keyboards";
      };
    };
  };
}
