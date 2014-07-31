package="Change Login Shell"

if [[ ! $(echo ${SHELL}) == $(which zsh) ]]; then
  sudo sh -c "which zsh >> /etc/shells"
  chsh -s $(which zsh)
  log_done ${package}
else
  log_skip ${package}
fi
