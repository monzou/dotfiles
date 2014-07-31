#!/bin/bash
set -e

function log() {
  echo -e "\033[32m$@\033[m"
}

HOMESHICK_DIR=${HOME}/.homesick
HOMESHICK_REPO=${HOMESHICK_DIR}/repos/homeshick
DOTFILES_REPO=${HOMESHICK_DIR}/repos/dotfiles

# Install homeshick
if [[ ! -d "${HOMESHICK_REPO}" ]]; then
  log "Cloning homeshick ..."
  git clone https://github.com/andsens/homeshick.git ${HOMESHICK_REPO}
else
  log "Pulling homeshick ..."
  ( cd ${HOMESHICK_REPO}; git pull )
fi
type homeshick &> /dev/null || source ${HOMESHICK_REPO}/homeshick.sh

# Install dotfiles
if [[ ! -d "${DOTFILES_REPO}" ]]; then
  log "Cloning dotfiles ..."
  homeshick clone monzou/dotfiles
else
  log "Pulling dotfiles ..."
  homeshick pull dotfiles
fi
homeshick cd dotfiles
git submodule update --init

log "Linking dotfiles ..."
homeshick symlink dotfiles

# Run installation scripts
log "Running installation scripts ..."
workspace=/tmp/dotfiles
bootstrap=${workspace}/bootstrap.sh
mkdir -p ${workspace}
cat scripts/* > ${bootstrap}
bash ${bootstrap}

# Cleanup
rm -rf ${workspace}

log "Installation finished !"