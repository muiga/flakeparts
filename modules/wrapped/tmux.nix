{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.myTmux = inputs.wrapper-modules.wrappers.tmux.wrap {
        inherit pkgs;
        settings = {
          enable = true;
          prefix = "C-Space";
          mouse = true;
          baseIndex = 1;
          terminal = "screen-256color";
          keyMode = "vi";

          plugins = with pkgs.tmuxPlugins; [
            sensible
            yank
            vim-tmux-navigator
            catppuccin
            prefix-highlight
            battery
            cpu
          ];

          extraConfig = ''
            set-option -sa terminal-overrides ",xterm*:Tc"
            # Prefix key
            bind C-Space send-prefix
            # Vim style pane selection
            bind h select-pane -L
            bind j select-pane -D
            bind k select-pane -U
            bind l select-pane -R
            # Pane settings
            set -g pane-base-index 1
            set-window-option -g pane-base-index 1
            set-option -g renumber-windows on
            # Use Alt-arrow keys without prefix key to switch panes
            bind -n M-Left select-pane -L
            bind -n M-Right select-pane -R
            bind -n M-Up select-pane -U
            bind -n M-Down select-pane -D
            # Shift arrow to switch windows
            bind -n S-Left  previous-window
            bind -n S-Right next-window
            # Shift Alt vim keys to switch windows
            bind -n M-H previous-window
            bind -n M-L next-window
            # Catppuccin flavour
            set -g @catppuccin_flavor "mocha"
            set -g @catppuccin_window_status_style "rounded"
            # Vi-mode keybindings
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
            # Split windows with current path
            bind '"' split-window -v -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"
            # Status line
            set -g status-right-length 100
            set -g status-left-length 100
            set -g status-left "#{E:@catppuccin_status_session} "
            set -g status-right "#{E:@catppuccin_status_application}"
            set -ag status-right " #[fg=#89b4fa,bg=#1e1e2e] %Y-%m-%d %H:%M "
          '';
        };
      };
    };
}
