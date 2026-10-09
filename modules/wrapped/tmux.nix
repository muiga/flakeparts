{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.myTmux = inputs.wrapper-modules.wrappers.tmux.wrap {
        inherit pkgs;

        prefix = "C-Space";
        terminal = "screen-256color";
        terminalOverrides = ",xterm*:Tc";
        modeKeys = "vi";
        vimVisualKeys = true;
        sourceSensible = true; # replaces the `sensible` plugin entry
        # mouse, baseIndex and paneBaseIndex already default to true / 1 / 1

        plugins = [
          { plugin = pkgs.tmuxPlugins.yank; }
          { plugin = pkgs.tmuxPlugins.vim-tmux-navigator; }
          {
            plugin = pkgs.tmuxPlugins.catppuccin;
            configBefore = ''
              set -g @catppuccin_flavor "mocha"
              set -g @catppuccin_window_status_style "rounded"
            '';
          }
          { plugin = pkgs.tmuxPlugins.prefix-highlight; }
          { plugin = pkgs.tmuxPlugins.battery; }
          { plugin = pkgs.tmuxPlugins.cpu; }
        ];

        configBefore = ''
          set-option -g renumber-windows on

          # Vim style pane selection
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # Alt-arrows switch panes without prefix
          bind -n M-Left select-pane -L
          bind -n M-Right select-pane -R
          bind -n M-Up select-pane -U
          bind -n M-Down select-pane -D

          # Shift-arrows / Shift-Alt-vim switch windows
          bind -n S-Left previous-window
          bind -n S-Right next-window
          bind -n M-H previous-window
          bind -n M-L next-window

          # Copy mode
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

          # Splits keep the current path
          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
        '';

        # Must run after catppuccin is sourced, because it defines these status modules
        configAfter = ''
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left "#{E:@catppuccin_status_session} "
          set -g status-right "#{E:@catppuccin_status_application}"
          set -ag status-right " #[fg=#89b4fa,bg=#1e1e2e] %Y-%m-%d %H:%M "
        '';
      };
    };
}
