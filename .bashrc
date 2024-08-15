#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff -u --color=auto'
alias ..='cd ..'

export EDITOR=/usr/bin/micro
export TERM=xterm-color

# Set the PS1 variable
# Define the PS1 prompt
# PS1='[\u@\h \W]\$ '

# https://gist.github.com/rchowe/1727301
## Set the prompt to display the current git branch
## and use pretty colors
PS1='$(git branch &>/dev/null; if [ $? -eq 0 ]; then \
echo "\[\e[1m\]\u@\h\[\e[0m\]: \w [\[\e[34m\]$(git branch | grep ^* | sed s/\*\ //)\[\e[0m\]\
$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; if [ "$?" -ne "0" ]; then \
echo "\[\e[1;31m\]*\[\e[0m\]"; fi)] \$ "; else \
echo "\[\e[1m\]\u@\h\[\e[0m\]: \w \$ "; fi )'

eval "$(zoxide init bash)"
