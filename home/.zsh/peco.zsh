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
function peco-pkill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}

# snippets
function peco-snippets() {
  BUFFER=$(grep -v "^#" ~/Dropbox/dev/snippets.txt | peco --query "$LBUFFER")
  zle clear-screen
}
zle -N peco-snippets
bindkey '^x^x' peco-snippets

# find
function peco-find-file() {
  if git rev-parse 2> /dev/null; then
    source_files=$(git ls-files)
  elif hg status 2> /dev/null; then
    source_files=$(hg manifest)
  else
    source_files=$(find . -type f)
  fi
  selected_files=$(echo $source_files | peco --prompt "[find file]")
  result=''
  for file in $selected_files; do
    result="${result}$(echo $file | tr '\n' ' ')"
  done
  BUFFER="${BUFFER}${result}"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-find-file
bindkey '^f^f' peco-find-file

# ag
function peco-ag-vim() {
  vim $(ag "$@" | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
zle -N peco-ag-vim

function peco-ag-less() {
  aa $@ | peco --query "$LBUFFER" | awk -F : '{print $1}' | xargs less -iMR
}
zle -N peco-ag-less
