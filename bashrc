# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


export EDITOR=nano

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set correct language
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ... or force ignoredups and ignorespace
export HISTSIZE=16384;
export HISTFILESIZE=40960;
export HISTCONTROL=ignoreboth:erasedups;
export HISTTIMEFORMAT="%Y%m%d %H:%M:%S "
export PROMPT_COMMAND="history -a"

# append to the history file, don't overwrite it
shopt -s histappend;

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

symhost="`cat /etc/symbolic_hostname 2> /dev/null`.d"
if [ "$symhost" == ".d" ]; then
    symhost=`hostname`
fi

alias l='ls -la --color=auto'

if [ "$color_prompt" = yes ]; then

    # Blue for own comp
    if [[ ${symhost:0:14} = "mikens-macbook" ]]; then
        color="6"
        export CLICOLOR=1
        export LSCOLORS=ExGxcxdxCxegedabagacad
        alias l='ls -lAF'

    # My server
    elif [ "$symhost" = "arielle" ]; then
        color="5"

    # Green for dev
    elif [[ $symhost =~ ^dev\.[-a-zA-Z0-9]+\.d$ ]] || [[ $symhost =~ ^play\.miken(\.[a-z]+)?$ ]]; then
        color="2"
    
    # Yellow for testing and unstable
    elif [[ $symhost =~ www-[0-9]+\.testing\.d$ ]]; then
        color="3"

    # Red for production or unknown
    else
        color="1"
    fi

    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;3${color}m\]\u\[\033[01;33m\]@\[\033[01;3${color}m\]$symhost\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@$symhost:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}: ${PWD/$HOME/~}\007"'
     ;;
*)
     ;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto --exclude-dir=.svn --exclude-dir=.git'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias lr='ls -ltr'
alias rm='rm -i'
alias ssh='ssh -A'
alias cp='cp -i'
alias mv='mv -i'
alias sl='cowsay "slow down boi!";sleep 2'
# enable programmable completion features (if not enabled)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
