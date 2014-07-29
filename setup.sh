#!/bin/bash
set -xe

HOMESHICK_DIR=$HOME/.homesick
HOMESHICK=$HOMESHICK_DIR/repos/homeshick
DOTFILES=$HOMESHICK_DIR/repos/dotfiles

# Install homeshick
if [[ ! -d $HOMESHICK ]]; then
  git clone https://github.com/andsens/homeshick.git $HOMESHICK
else
  ( cd $HOMESHICK; git pull )
fi
type homeshick &> /dev/null || source $HOMESHICK/homeshick.sh

# Install dotfiles
if [[ ! -d $DOTFILES ]]; then
  homeshick clone monzou/dotfiles
else
  homeshick pull dotfiles
fi
homeshick cd dotfiles
git submodule update --init
homeshick symlink dotfiles

# Run installation scripts
cat scripts/* > /tmp/setup.sh
bash /tmp/setup.sh
rm -rf /tmp/setup.sh
