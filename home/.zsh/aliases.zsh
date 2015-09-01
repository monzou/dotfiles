alias ll="ls -la"
alias zz="source ~/.zshrc"

alias dot="homesick cd dotfiles"
alias dotsym="homesick symlink dotfiles"
alias dotbundle="dot && bundle"

alias gs="git status --short"
alias gd="git diff"
alias ga="git add -A"
alias gc="git commit"
alias gp="git pull"
alias gpp="git push"

alias jj="/usr/libexec/java_home -v"

alias review="osascript ~/.scripts/things_review.scpt"
alias esync="cd ~/Dropbox/docs/english/ && mailbot sync && popd"
alias eedit="subl ~/Dropbox/docs/english/index.md"

alias pp="ps aux | peco"
alias pk="peco-pkill"
alias vv="peco-ag-vim"
alias aa="peco-ag-less"

alias xl="tmux list-session"
alias xa="tmux attach -t"
alias xd="tmux detach"
alias xn="tmux new -s"
alias xk="tmux kill-session -t"
alias xkk="tmux kill-session"
alias xs="tmux kill-server"
