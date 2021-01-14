# bash prompt
# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[32m\]>\[\e[m\] \[\e[34m\]\W\[\e[m\] \[\e[31m\]\`parse_git_branch\`\[\e[m\] "

# find aliaese
function ff() {
    if [ "$#" -ne 1 ]; then
        echo "illegal number of parameters"
    fi
    find . -type f -name $1
}

function fd() {
    if [ "$#" -ne 1 ]; then
        echo "illegal number of parameters"
    fi
    find . -type d -name $1
}

# docker aliases
function dk() {
    case "$1" in 
    "img")
        docker images
        ;;
    "pa")
        docker ps -all 
        ;;
    "ph")
        shift 
        docker push $@
        ;;
    "r")
        shift
        docker run $@
        ;;
    "lt")
        shift
        declare -i num_rd=$1
        docker images | awk "NR<$((num_rd+2)){print}"
        ;;
    *)
        docker $@
        ;;
    esac
}

function gsw() {
    email=$(git config user.email)    
    name=$(git config user.name)
    if [ $email = "charleszheng44@gmail.com" ]; 
    then
        git config user.email "c.zheng@alibaba-inc.com"
        [ "$name" != "c.zheng" ] && git config user.name "c.zheng"
    else
        git config user.email "charleszheng44@gmail.com"
        [ "$name" != "chao zheng" ] && git config user.name "chao zheng"
    fi
}

function gwmi() {
    cat << EOF
$(git config user.email)
$(git config user.name)
EOF
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# golang setting
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Work/go
export PATH=$PATH:$GOPATH/bin
export GOPRIVATE="github.com/charleszheng44"
export GODOCC_STYLE="dracula"

# k8s setting
export PATH=$PATH:/usr/local/kubebuilder/bin

# setup gcloud
export PATH=$PATH:$HOME/google-cloud-sdk/bin

# homebrew env variable
export HOMEBREW_NO_AUTO_UPDATE=1

# set default edit
export EDITOR=nvim

# install plugins
for config_fn in $HOME/.config/bash/*; do
    source ${config_fn}
done

# bash autocomplete
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
source ~/.kube/kubectl_autocompletion

export TERM=xterm-256color
export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/python@3.9/bin:$PATH"
