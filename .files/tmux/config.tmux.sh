# ================================================================================= [Config] ===== #

# Set default shell
set-option -g default-shell /bin/zsh

# History Limit
set -g history-limit 10000

# Top Tmux Bar
set-option -g status-position top

# automatically renumber tmux windows
set -g renumber-windows on

# Disable Auto Rename
set-option -g allow-rename off

# Activity Monitoring
setw -g monitor-activity off
set -g visual-activity off

# Aggressive Resize
setw -g aggressive-resize on

# Shorter Delay
set -sg escape-time 0

# Tiled Windows
unbind =
bind = select-layout tiled

# Window Index 1
set -g base-index 1
setw -g pane-base-index 1

# Window Title
set-option -g set-titles on
set-option -g set-titles-string "#T - #W"

# TMUX color
set -g default-terminal 'screen-256color'
