# Constants
DROPBOX_DIR="$HOME/Dropbox"
SUBLIME_DIR="$HOME/Library/Application Support/Sublime Text 3/"

# Setup Dropbox
if [ -d $DROPBOX_DIR ]; then
  # Sync dev
  [ ! -L $HOME/dev ] && ln -s -f $DROPBOX_DIR/dev $HOME/dev
  # Sync sublime settings
  if [ -e "$SUBLIME_DIR" ]; then
    rm -rf "$SUBLIME_DIR/Packages/"
    rm -rf "$SUBLIME_DIR/Installed\ Packages/"
    ln -s "$DROPBOX_DIR/dev/env/sublime/Packages" "$SUBLIME_DIR/Packages"
    ln -s "$DROPBOX_DIR/dev/env/sublime/Installed Packages" "$SUBLIME_DIR/Installed Packages"
  fi
fi

