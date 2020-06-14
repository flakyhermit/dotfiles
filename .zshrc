# The following lines were added by compinstall
autoload -U promptinit; promptinit
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' '' '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/monk/.zshrc'

zstyle ':prompt:grml:left:items:braceo' pre '['
zstyle ':prompt:grml:left:items:bracec' pre ']'
zstyle ':prompt:grml:left:setup' items rc change-root user at host path percent 
# autoload -Uz compinit
# compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="nvim"
export PATH="${PATH}:${HOME}/bin:${HOME}/.local/bin"
export WM="i3"
# Personal DIRs
export DROPBOX="${HOME}/Dropbox"
export BLOG_POSTS="${DROPBOX}/Documents/Blog Posts"
export PROJECTS="${HOME}/Projects"
export AWESOME="${HOME}/.config/awesome/"
# Aliases
alias edit="nvim"
#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#-----------------------------
# Scripts
#-----------------------------
# /home/monk/Dropbox/learn_hindi.sh
# grml_prompt_token_default[percent]='%(#.#.$) '

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)

# Custom functions
setxkbmap -option 'caps:escape'
# Git for dotfiles
alias dots='/usr/bin/git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME'
setxkbmap -option 'caps:escape'
