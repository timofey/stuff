#
# ~/.bashrc
#

export HISTCONTROL=erasedups
export HISTFILESIZE=-1
export HISTSIZE=-1
export HISTIGNORE='#*'

export DOCKER_ID_USER="your-user-id"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# setup bash completions
source "/usr/share/bash-completion/completions/git"
source "/usr/share/bash-completion/completions/ant"
source "/usr/share/bash-completion/completions/java"
source "/usr/share/bash-completion/completions/javac"
source "/usr/share/bash-completion/completions/yay"
source "/usr/share/bash-completion/completions/pacman"
source "/usr/share/bash-completion/completions/pacman-key"
source "/usr/share/bash-completion/completions/lsof"
source "/usr/share/bash-completion/completions/sysctl"
source "/usr/share/bash-completion/completions/systemctl"
source "/usr/share/bash-completion/completions/docker"
source "/usr/share/bash-completion/completions/tcpdump"
source "/usr/share/bash-completion/completions/loginctl"
source "/usr/share/bash-completion/completions/journalctl"
source "/usr/share/bash-completion/completions/sudo"
source "/usr/share/bash-completion/completions/su"
source "/usr/share/bash-completion/completions/chown"
source "/usr/share/bash-completion/completions/chgrp"
source "/usr/share/bash-completion/completions/dd"
source "/usr/share/bash-completion/completions/make"
source "/usr/share/bash-completion/completions/pkill"
source "/usr/share/bash-completion/completions/adb"
source "/usr/share/bash-completion/completions/fastboot"

# <C-w> deletes word-by-word, eg. /a/b/c/ will be deleled as: /a/b/c/ → /a/b/ → /a/ etc.
stty werase undef
bind '\C-w:unix-filename-rubout'

# setup your editor
export EDITOR=/usr/bin/vim

# correct coloring in some terminal emulators
export TERM="xterm-256color"

# skin for midnight commander
export MC_SKIN=/home/timofey/.mc/skins/candy256.ini

export LC_NUMERIC="en_US.UTF-8"

# bunch of useful stuff
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hgrep='history | grep'
alias svim='sudo vim'

alias py='bpython'
alias jshell='/usr/lib/jvm/java-10-openjdk/bin/jshell'

alias add-commit='git add . && git commit'
alias gpull='git pull -r && git submodule update'
alias gadd='git add -i'

# alias node='nodejs' -- fix for debian-like distors
alias weather='curl http://ru.wttr.in'

# you're supposed to yell it while you type
eval "$(thefuck --alias)"
alias FUCK='fuck'

alias s='sudo'
alias КУИЩЩЕ='reboot'
alias потухни='shutdown now'


function mkcdir() {
    mkdir $1 && cd $1;
}

function psaux() {
    ps aux | grep $1;
}

function spl() {
    awk -F"$1" "{print $"$2"}"
}


# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
        echo " (${BRANCH}${STAT})"
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

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL "
}

function get_mc_status() {
    if [ -z ${MC_SID+x} ]; then
        echo -n ""
    else
        echo -en " \e[31m(mc)\e[0m"
    fi
}

# this below is a special kind of magic: time spend by each executed command

function timer_get_time() {
    echo -n "$(date +%s%N | cut -b1-13)"
}

function format_spent_time() {
    sp_time="$1"
    if (( $(bc <<< "$sp_time > 3599.99") )); then
        sp_hours="$(bc <<< "$sp_time / 3600")"
        sp_left_seconds="$(bc <<< "$sp_time - $sp_hours * 3600")"
        sp_minutes="$(bc <<< "$sp_left_seconds / 60")"
        sp_seconds="$(bc <<< "scale=1;($sp_left_seconds - $sp_minutes * 60)/1")"
        echo -n "${sp_hours}h ${sp_minutes}m ${sp_seconds}s"
    elif (( $(bc <<< "$sp_time > 59.99") )); then
        sp_minutes="$(bc <<< "$sp_time / 60")"
        sp_seconds="$(bc <<< "scale=1;($sp_time - $sp_minutes * 60)/1")"
        echo -n "${sp_minutes}m ${sp_seconds}s"
    else
        echo -n "$(printf "%.2f" "$sp_time")s"
    fi
}

function timer_start() {
    timer=${timer:-$(timer_get_time)}
}

function timer_stop() {
    curr_time="$(timer_get_time)"
    seconds_pass="$(bc <<< "scale=2;($curr_time - $timer) / 1000")"
    if (( $(bc <<< "$seconds_pass > 0") )); then
        timer_show="$(format_spent_time "$seconds_pass") "
    else
        timer_show=""
    fi
    unset timer
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
    PROMPT_COMMAND="timer_stop"
else
    PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi




export PS1="\${timer_show}\[\e[31;40m\]\`nonzero_return\`\[\e[m\]\[\e[37m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[32m\]\W\`get_mc_status\`\[\e[m\]\[\e[37m\]]\[\e[m\]\[\e[37m\]\[\e[36m\]\`parse_git_branch\`\[\e[m\] \\$\[\e[m\] "

