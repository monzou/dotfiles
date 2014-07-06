#!/bin/bash
set -xe

# Install homeshick
if [[ ! -d $HOME/.homesick/repos/homeshick ]]; then
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
else
  ( cd $HOME/.homesick/repos/homeshick; git pull )
fi
type homeshick &> /dev/null || source $HOME/.homesick/repos/homeshick/homeshick.sh

# Setup dotfiles
if [[ ! -d $HOME/.homesick/repos/dotfiles ]]; then
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
brew bundle $HOME/.homesick/repos/dotfiles/Brewfile

# Setup Dropbox
$HOME/.homesick/repos/dotfiles/dropbox.sh
