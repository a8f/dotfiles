#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\W]\$ '
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
alias sd='sudo shutdown 0'
alias ovpn='sudo -E openvpn ~/client.ovpn'

cdd(){
    cd "$1"
    ls -l --color=always | head -n 10
}

cds(){
    cd "$1"
    ls -l --color=always | less -R
}

