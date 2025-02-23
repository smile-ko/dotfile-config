# aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias hyperconfig="nvim ~/.hyper.js"

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

# EDN
alias edn='cd ~/EDN-Projects/ && ls'

# script
alias ide='~/.config/.script/tmux_layout.sh'
