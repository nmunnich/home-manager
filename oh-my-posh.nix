{
  programs.oh-my-posh = {
    enable = true;
    settings = {
      "$schema" =
        "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      blocks = [
        {
          alignment = "left";
          segments = [
            {
              foreground = "#26C6DA";
              style = "plain";
              template = "{{ if .WSL }}WSL at {{ end }}{{.Icon}} ";
              type = "os";
            }
            {
              foreground = "#26C6DA";
              style = "diamond";
              template = "{{ .UserName }}@{{ .HostName }} ";
              type = "session";
            }
            {
              foreground = "#0fc469";
              style = "powerline";
              template =
                "➜ ({{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Major }}.{{ .Minor }}{{ end }}) ";
              type = "python";
            }
            {
              foreground = "#FFE700";
              foreground_templates = [
                "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#FFCC80{{ end }}"
                "{{ if gt .Ahead 0 }}#16c60c{{ end }}"
                "{{ if gt .Behind 0 }}#f450de{{ end }}"
              ];
              properties = {
                fetch_status = true;
                fetch_upstream_icon = true;
              };
              style = "plain";
              template =
                "{{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }} ";
              type = "git";
            }
          ];
          type = "prompt";
        }
        {
          alignment = "right";
          segments = [
            {
              background = "#6CA35E";
              foreground = "#ffffff";
              leading_diamond = "";
              style = "diamond";
              template = " {{ .Full }} ";
              trailing_diamond = "";
              type = "node";
            }
            {
              background = "#4c1f5e";
              foreground = "#ffffff";
              leading_diamond = " ";
              style = "diamond";
              template = " {{ .Full }} ";
              trailing_diamond = "";
              type = "java";
            }
            {
              properties = { always_enabled = true; };
              style = "plain";
              template =
                " {{ if gt .Code 0 }}<#ff0000></>{{ else }}<#23d18b></>{{ end }} ";
              type = "status";
            }
            {
              foreground = "#bab02a";
              properties = { threshold = 10; };
              style = "plain";
              template = "took  {{ .FormattedMs }} ";
              type = "executiontime";
            }
            {
              foreground = "#00C5C7";
              properties = { time_format = "15:04:05"; };
              style = "plain";
              template = " {{ .CurrentDate | date .Format }}  ";
              type = "time";
            }
          ];
          type = "prompt";
        }
        {
          alignment = "left";
          newline = true;
          segments = [
            {
              foreground = "#77E4F7";
              properties = { style = "letter"; };
              style = "plain";
              template = "{{ .Path }} ";
              type = "path";
              alias = "path";
            }
            {
              foreground = "#43D426";
              style = "plain";
              template = "❯ ";
              type = "text";
              alias = "arrow";
            }
          ];
          type = "prompt";
        }
      ];
      "transient_prompt" = {
        "background" = "transparent";
        "foreground" = "#77E4F7";
        "template" =
          "{{if eq .Folder .UserName}}~{{else}}{{ .Folder }}{{end}} <#43D426>❯</> ";
      };
      version = 2;
    };
  };
}
