# PATH
export PATH="/usr/local/bin:$PATH"

# Make sure system is up-to-date
sudo softwareupdate --install --all

# Install Xcode's CLI-tools
xcode-select --install

# Install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

