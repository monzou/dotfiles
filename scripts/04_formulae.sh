package="Update Formulae"

which brew
if [ $? == 0 ]; then
  brew bundle
  brew cask alfred link
  echo ""
  log_done ${package}
else
  log_skip ${package}
fi
