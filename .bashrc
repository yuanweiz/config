#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;34m\][\u \W]\$\[\e[0m\] '
if [ -z $SET_ENV_ONCE ] # not yet set
then
    SET_ENV_ONCE='set'
    export GOPATH=~/go
    export SET_ENV_ONCE
    PATH="$PATH:$GOPATH/bin"
    PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
    PATH="$HOME/usr/bin:$PATH"
    export PATH
fi
