package="Sync Dropbox Settings"

DROPBOX_DIR="${HOME}/Dropbox"
SUBLIME_DIR="${HOME}/Library/Application Support/Sublime Text 3/"

if [[ -d "${DROPBOX_DIR}" ]]; then
  # Sync dev
  package="Sync dev w/ Dropbox"
  if [[ ! -L "${HOME}/dev" ]]; then
    ln -sf ${DROPBOX_DIR}/dev ${HOME}/dev
    log_done ${package}
  else
    log_skip ${package}
  fi
  # Sync sublime settings
  if [[ -e "${SUBLIME_DIR}" ]]; then
    package="Sync Sublime Packages w/ Dropbox"
    if [[ ! -L "${SUBLIME_DIR}/Packages" ]]; then
      rm -rf "${SUBLIME_DIR}/Packages"
      ln -sf "${DROPBOX_DIR}/dev/env/sublime/Packages" "${SUBLIME_DIR}/Packages"
      log_done ${package}
    else
      log_skip ${package}
    fi
    package="Sync Sublime Installed Packages w/ Dropbox"
    if [[ ! -L "${SUBLIME_DIR}/Installed Packages" ]]; then
      rm -rf "${SUBLIME_DIR}/Installed Packages"
      ln -sf "${DROPBOX_DIR}/dev/env/sublime/Installed Packages" "${SUBLIME_DIR}/Installed Packages"
      log_done ${package}
    else
      log_skip ${package}
    fi
  fi
else
  log_skip "Sync Dropbox Settings"
fi
