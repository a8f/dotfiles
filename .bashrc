# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=always'
PS1='[\W]\$ '
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

alias sd='sudo shutdown 0'
alias ovpn='sudo -E openvpn ~/client.ovpn'

# cd && ls | head
cdd(){
    cd "$1"
    ls -l --color=always | head -n 10
}
# cd && ls | less
cds(){
    cd "$1"
    ls -l --color=always | less -R
}
# cd && ls
cdls(){
    cd "$1"
    ls --color=always
}
# cd && ls -l
cdlsl(){
    cd "$1"
    ls -l --color=always
}
# mkdir && cd
mkent(){
    mkdir "$1"
    cd "$1"
}

sizeof(){
    du -h "$1" | sort -h
}

# clear && ls
cls(){
    clear
    if [ -z "$1" ]
    then
        ls --color=always
    else
        ls "$1" --color=always
    fi
}
# clear && ls -l
clsl(){
    clear
    if [ -z "$1" ]
    then
        ls --color=always -l
    else
        ls "$1" --color=always -l
    fi
}
