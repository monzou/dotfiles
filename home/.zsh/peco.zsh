if ! which peco > /dev/null; then
  return
fi

# git branch
alias -g GB='`git branch | peco | sed -e "s/^\*[ ]*//g"`'

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
function peco-pkill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"

# cd
function peco-cd() {
  local var
  local dir
  if [ ! -t 0 ]; then
  var=$(cat -)
  dir=$(echo -n $var | peco)
  else
      return 1
  fi

  if [ -d "$dir" ]; then
      cd "$dir"
  else
      echo "'$dir' was not directory." >&2
      return 1
  fi
}
alias pcd="peco-cd"

# open
function peco-open() {
  local var
  local file
  local command="open"
  if [ ! -t 0 ]; then
      var=$(cat -)
      file=$(echo -n $var | peco)
  else
      return 1
  fi

  if [ -n "$1" ]; then
    command="$1"
  fi

  if [ -e "$file" ]; then
      eval "$command $file"
  else
      echo "Could not open '$file'." >&2
      return 1
  fi
}
alias popen="peco-open"

# snippets
function peco-snippets() {
  BUFFER=$(grep -v "^#" ~/Dropbox/dev/snippets.txt | peco --query "$LBUFFER")
  zle clear-screen
}
zle -N peco-snippets
bindkey '^x^x' peco-snippets
