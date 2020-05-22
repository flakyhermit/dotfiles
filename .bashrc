# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Custom additions
# Bash prompt
PS1="\t \h \W \$ "
PS1="(`(sensors | grep Pack | cut -c 17-23)` `uptime | cut -f 5 -d ' ' | cut -c -4`) \n\t \h \W \$ "
PS1="\[\e[2;37m\](`(sensors | grep Pack | cut -c 17-23)`)  \n\t \[\e[00m\]\[\e[1;36m\]\h \[\e[00m\]\W \[\e[2;37m\]\$ \[\e[00m\]" 

PS1="\t \[\e[00m\]\[\e[1;36m\]\h \[\e[00m\]\W \[\e[2;37m\]\$ \[\e[00m\]" 

# Variables
export EDITOR="vim"
export XDG_CURRENT_DESKTOP=lxqt
export PROJECTS="$HOME/Projects/"
export SCRIPTDIR="$HOME/.Meta/scripts"
export PATH="$PATH:$HOME/.Meta/scripts:$HOME/.software"
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh

# Git for dotfiles
alias dots='/usr/bin/git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME'
setxkbmap -option 'caps:escape'
