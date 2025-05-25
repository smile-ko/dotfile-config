# aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# git
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gr='git remote -v'
alias ga='git add .'
alias gc='git commit --no-verify -m'
alias gca='git commit --no-verify --amend -m'
alias gp='git push origin'
alias gpf='git push -f origin'
alias gco='git checkout'
alias gcm='git checkout master && git pull origin master'
alias gl='git log --oneline --graph'

# helper
alias update='sudo apt update'
alias upgrade='sudo apt upgrade -y'
alias cls='clear'
alias vim='nvim'
alias go_pkg='cd $PATH_PACKAGES_LOCAL && ls'
alias system='htop'
alias http='nvim ~/https/'
alias google-s='open -a Google\ Chrome "https://google.com"'
alias google='open -a Google\ Chrome'

# tmux
alias tnew='tmux new -s'
alias tls='tmux ls'
alias ta='tmux attach -t'
alias td='tmux detach'
alias tk='tmux kill-session'
alias tsplitv='tmux split-window -v'
alias tsplith='tmux split-window -h'
alias tleft='tmux select-pane -L'
alias tright='tmux select-pane -R'
alias tup='tmux select-pane -U'
alias tdown='tmux select-pane -D'

# EDN Company
alias edn='cd ~/EDN-Projects/ && echo "[END] SOURCE:" && ls'
alias edn-http='nvim ~/EDN-Projects/https/'

# Workspace
alias wp='cd ~/workspaces && echo "My Workspace::" && ls'

# script
alias cmd='~/.config/.script/tmux_layout.sh'
alias cmd4='~/.config/.script/tmux_layout_4_equal_panes.sh'
alias config='cd ~/.config'
