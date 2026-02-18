# ================================================================================ [Hotkeys] ===== #

# Set Prefix
unbind C-b
set -g prefix C-g
bind C-g send-prefix

# Reload Config
bind r run-shell "~/.tmux/plugins/tpm/bin/install_plugins" \; source-file ~/.tmux.conf \; display-message "Config reloaded"

# Split Window
bind \\ split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind c new-window -c '#{pane_current_path}'

# Cycle Window
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# Synchronize Panes in Window
bind y setw synchronize-panes

# Pane Movement
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Resize Panes
bind -r H resize-pane -L 1
bind -r J resize-pane -D 1
bind -r K resize-pane -U 1
bind -r L resize-pane -R 1

# VIM Mode
setw -g mode-keys vi
unbind [
bind Escape copy-mode
unbind p
bind p paste-buffer
bind -Tcopy-mode-vi 'v' send -X begin-selection
bind -Tcopy-mode-vi 'y' send -X copy-pipe-and-cancel "tmux save-buffer - | reattach-to-user-namespace pbcopy"

# Opencode Mode
bind o new-window -n Opencode -c "#{pane_current_path}" "opencode .; read -p 'Press Enter to close...'"

# Buffers
bind C-c run "tmux save-buffer - | reattach-to-user-namespace pbcopy"
bind C-v run "tmux set-buffer $(reattach-to-user-namespace pbpaste); tmux paste-buffer"
