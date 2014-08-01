package="Update Formulae"

which brew > /dev/null
if [ $? == 0 ]; then
  brew bundle
  brew cask alfred link
  log_done ${package}
else
  log_skip ${package}
fi
