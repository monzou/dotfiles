#!/bin/bash

DROPBOX="$HOME/Dropbox"
SUBLIME="$HOME/Library/Application Support/Sublime Text 3/"

# Setup Dropbox
if [ -d $DROPBOX ]; then
  # Sync dev
  [ ! -L $HOME/dev ] && ln -s -f $DROPBOX/dev $HOME/dev
  # Sync sublime settings
  if [ -e "$SUBLIME" ]; then
    rm -rf "$SUBLIME/Packages/"
    rm -rf "$SUBLIME/Installed\ Packages/"
    ln -s "$DROPBOX/dev/env/sublime/Packages" "$SUBLIME/Packages"
    ln -s "$DROPBOX/dev/env/sublime/Installed Packages" "$SUBLIME/Installed Packages"
  fi
fi
