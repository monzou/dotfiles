alias ll="ls -la"
alias zz="source ~/.zshrc"

alias dot="homesick cd dotfiles"
alias dot-sym="homesick symlink dotfiles"
alias dot-bundle="dot && brew bundle"

alias gs="git status --short"
alias gd="git diff"
alias ga="git add -A"
alias gc="git commit"
alias gp="git pull"
alias gpp="git push"

alias jj="/usr/libexec/java_home -v"

alias review="osascript ~/.scripts/things_review.scpt"
alias e-edit="subl ~/Dropbox/docs/english/words.md"
alias e-sync="cd ~/Dropbox/docs/english && mailbot sync --file words.md && popd"
