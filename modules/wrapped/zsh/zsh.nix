{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      myAliases = {
        upgrade = "cd ~/nixosflake && sudo nix flake update && cd && sudo nixos-rebuild switch --flake ~/nixosflake";
        rebuild = "sudo nixos-rebuild switch --flake ~/nixosflake";
        update = "cd ~/nixosflake && sudo nix flake update && cd";
        clean-home = "nix-collect-garbage -d";
        clean-system = "sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        psql-u = "sudo -u postgres psql";
        connect-ec2 = "ssh -i ~/.ssh/i-keys.pem ubuntu@ec2-3-76-209-240.eu-central-1.compute.amazonaws.com";
        connect-contabo-mine = "ssh root@45.159.222.167";
        codium-ai = "sh ~/nixosflake/codeium.sh";
        wtm = "nohup webstorm . &";
        biome-init = "npm i -D -E @biomejs/biome && cat $BIOME_CONFIG > biome.json";
        ls = "eza --icons=always";
        cd = "z";
        logout = "loginctl terminate-user $USER";
        dev = "tmux new-session \\; split-window -h \\; split-window -v \\; select-pane -t 0";
      };
    in
    {
      packages.myZsh = inputs.wrapper-modules.wrappers.zsh.wrap {
        inherit pkgs;
        settings = {
          enable = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          enableCompletion = true;
          shellAliases = myAliases;

          initContent = ''
            export PATH=$PATH:${pkgs.oh-my-posh}/bin
            export OMP_CACHE_DISABLED=true
            eval "$(oh-my-posh init zsh --config ${./pure.toml})"
            export PATH=$PATH:${pkgs.fzf}/bin
            eval "$(fzf --zsh)"

            # --- fzf theme ---
            fg="#CBE0F0"
            bg="#011628"
            bg_highlight="#143652"
            purple="#B388FF"
            blue="#06BCE4"
            cyan="#2CF9ED"
            export FZF_DEFAULT_OPTS="--color=fg:$fg,bg:$bg,hl:$purple,fg+:$fg,bg+:$bg_highlight,hl+:$purple,info:$blue,prompt:$cyan,pointer:$cyan,marker:$cyan,spinner:$cyan,header:$cyan"

            # -- Use fd instead of fzf --
            export PATH=$PATH:${pkgs.fd}/bin
            export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
            export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
            export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

            _fzf_compgen_path() {
              fd --hidden --exclude .git . "$1"
            }

            _fzf_compgen_dir() {
              fd --type=d --hidden --exclude .git . "$1"
            }

            export PATH=$PATH:${pkgs.fzf-git-sh}/bin

            show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
            export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
            export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

            _fzf_comprun() {
              local command=$1
              shift
              case "$command" in
                cd)           fzf --preview 'eza --tree --color=always \{} | head -200' "$@" ;;
                export|unset) fzf --preview "eval 'echo $\{}'"         "$@" ;;
                ssh)          fzf --preview 'dig \{}'                   "$@" ;;
                *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
              esac
            }

            # ---- Zoxide (better cd) ----
            eval "$(zoxide init zsh)"
          '';
        };
      };
    };
}
