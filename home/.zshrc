#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -Uz url-quote-magic bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Keybind
bindkey -e

# Source custom settings
for file in `/bin/ls ~/.zsh/*`
do
  if [[ -f $file ]]; then
    source $file
  fi
done
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/monzou/.sdkman"
[[ -s "/Users/monzou/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/monzou/.sdkman/bin/sdkman-init.sh"
