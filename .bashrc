# If not running interactively, don't do anything
[[ $- != *i* ]] && return
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
alias ls='ls --color=always'
PS1='[\W]\$ '
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
alias sd='sudo shutdown 0'
alias ovpn='sudo -E openvpn ~/client.ovpn &'

# ignore ctrl+s and ctrl+q
stty -ixon

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
mkcd(){
    mkdir "$1"
    cd "$1"
}

sizeof(){
    du -h "$1" | sort -h
}

# clear && ls -l
cls(){
    clear
    if [ -z "$1" ]
    then
        ls --color=always -l
    else
        ls "$1" --color=always -l
    fi
}
