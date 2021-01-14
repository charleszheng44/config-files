#!/usr/bin/env bash
# aliases
alias ls='ls -G'
alias ..='cd ..'
alias t='tmux'
alias v='nvim'
alias vim='nvim'
alias f='fc'
alias hty='HISTTIMEFORMAT="%d/%m/%y %T " history'
alias o='open'
alias src='source'

# kubectl aliases
kc() {
    case "$1" in
    "ap")
        shift
        kubectl apply $@
        ;;
    "del")
        if [ "$2" == "all" ]; then
            kubectl delete $3 $(kubectl get $3 | awk 'NR>1{print $1}')
        else
            shift
            kubectl delete $@
        fi
        ;;
    "des")
        shift
        kubectl describe $@
        ;;
    *)
        kubectl $@
        ;;
    esac
}

# git aliases
alias gcm='git commit'
alias gst='git status'
alias gdif='git diff'
alias gph='git push'
alias gpl='git pull'
alias glg='git log'
alias gch='git checkout'
# git add modified files
alias gam='git add $(git ls-files -m)'
alias gad='git add'
alias gbr='git branch'
alias grb='git rebase'

# go cli aliases
alias god='godocc'
alias gog='go get -u'

# colorful cat
alias ccat='pygmentize -g'
