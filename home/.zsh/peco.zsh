if ! which peco > /dev/null; then
  return
fi

# history
function peco-select-history() {
  typeset tac
  if which tac > /dev/null; then
    tac=tac
  else
    tac='tail -r'
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# integrate all source code with ghq
function peco-src() {
  local selected_dir=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${GOPATH}/src/${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
stty -ixon
bindkey '^s' peco-src

# process kill
function peco-kill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
zle -N peco-kill
bindkey '^k' peco-kill

# ssh
function peco-ssh () {
  local selected_host=$(awk '
  tolower($1)=="host" {
    for (i=2; i<=NF; i++) {
      if ($i !~ "[*?]") {
        print $i
      }
    }
  }
  ' ~/.ssh/config | sort | peco --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ssh
bindkey '^h' peco-ssh

# snippets
function peco-snippets() {
  BUFFER=$(grep -v "^#" ~/Dropbox/dev/snippets.txt | peco --query "$LBUFFER")
  zle clear-screen
}
zle -N peco-snippets
bindkey '^x^x' peco-snippets

# sublime
function peco-ag-sublime() {
  subl $(ag "$@" | peco --query "$LBUFFER" | awk -F : '{print $1 ":" $2}')
}
zle -N peco-ag-sublime

# cot-editor
function peco-ag-cot() {
  cot $(ag "$@" | peco --query "$LBUFFER" | awk -F : '{print $1 " --line " $2}')
}
zle -N peco-ag-cot
