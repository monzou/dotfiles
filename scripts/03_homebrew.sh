package="Install Homebrew"

which brew > /dev/null
if [ $? != 0 ]; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  log_done ${package}
else
  log_skip ${package}
fi
