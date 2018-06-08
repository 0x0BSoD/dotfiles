# some vars for i3 and other
export PATH=$PATH:$HOME/.scripts
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="chromium"
export BLOCKSIZE=Mb

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# zsh tune
DIRSTACKSIZE=20
READNULLCMD="cat"
CORRECT_IGNORE="_*"
WORDCHARS=':*?_-.[]~&;!#$%^(){}<>|'
watch=(notme)
LOGCHECK=10
REPORTTIME=5
COMPLETION_WAITING_DOTS="true"
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# aliases
alias grep='nocorrect grep --color=auto --exclude="*.pyc" --exclude-dir=".svn" --exclude-dir=".hg" --exclude-dir=".bzr" --exclude-dir=".git"';

alias ls='ls -Fh --color=auto'
alias ll='ls -Fhl --color=auto'
alias la='ls -FhlA --color=auto'
alias li='ls -Fhial --color=auto'
alias lsa='ls -Fhld --color=auto .*'

alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -I'

alias rehash="hash -r"

alias ga='git add'
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias gg='git pull'
alias gb='git checkout'
