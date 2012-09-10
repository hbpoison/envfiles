# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler gem git osx rbenv ruby)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:$PATH
export EDITOR=/usr/local/bin/vim

# alias
alias mongodb-up="mongod run --config /usr/local/etc/mongod.conf"
alias redis-up="redis-server /usr/local/etc/redis.conf"

## irssi stuff
# create the pane with irssi's nicklist
function irssi_nickpane() {
  tmux renamew irssi
  tmux -q setw main-pane-width $(( $(tput cols) - 21))
  tmux splitw -v "cat ~/.irssi/nicklistfifo"
  tmux -q selectl main-vertical
  tmux selectw -t irssi
  tmux selectp -t 1
}
# irssi wrapper
function irssi() {
  irssi_nickpane
  /usr/bin/env irssi
}
# repair running irssi's nicklist pane
function irssi_repair() {
  tmux selectw -t irssi
  tmux selectp -t 0
  tmux killp -a
  irssi_nickpane
}
##
