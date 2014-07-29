#!/bin/bash
set -xe

HOMESHICK_DIR=$HOME/.homesick
HOMESHICK=$HOMESHICK_DIR/repos/homeshick
DOTFILES=$HOMESHICK_DIR/repos/dotfiles

# Install Xcode
xcode-select --install

# Install homeshick
if [[ ! -d $HOMESHICK ]]; then
  git clone https://github.com/andsens/homeshick.git $HOMESHICK
else
  ( cd $HOMESHICK; git pull )
fi
type homeshick &> /dev/null || source $HOMESHICK/homeshick.sh

# Setup dotfiles
if [[ ! -d $DOTFILES ]]; then
  homeshick clone monzou/dotfiles
else
  homeshick pull dotfiles
fi
homeshick cd dotfiles
git submodule update --init
cd $HOME
homeshick symlink dotfiles

# Install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Install homebrew bundles
brew bundle $DOTFILES/Brewfile

# Setup Dropbox
$DOTFILES/dropbox.sh

# Setup Alfred
brew cask alfred link

# Change shell
chsh -s /bin/zsh