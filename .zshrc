export PATH=$PATH:$HOME/.scripts
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="chromium"
export ZSH=/home/alex/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(
  git
  zsh-syntax-highlighting
)

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
alias grep='nocorrect grep --color=auto --exclude="*.pyc" --exclude-dir=".svn" --exclude-dir=".hg" --exclude-dir=".bzr" --exclude-dir=".git"';
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

autoload -Uz compinit && {
    compinit -u
    zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
    zstyle ':completion:*:(rm|mv|scp|ls):*' ignore-line yes
    zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'
    zstyle ':completion:*:processes' command 'ps -w -w -a -u $(whoami) -o pid,cmd --sort=-pid | sed "/ps/d"'
    zstyle ':completion:*:processes' insert-ids menu yes select
    zstyle ':completion:*:processes-names' command "ps $([[ $UID == 0 ]] && echo a) h x -o command | sed -r -e '/(^\[.*\]$|^init|^-|^ps|^sed)/d'"
    zstyle ':completion:*:processes' sort false
    zstyle ':completion:*:processes' list-colors "=(#b) #([0-9]#)*=38;5;14;1=38;5;9;1"

    zstyle -e ':completion:*:hosts' hosts 'reply=(
   	 ${${${${${(f)"$(cat ${HOME}/.ssh/known_hosts 2>/dev/null)"//\[/}//\]:/ }:#[\|]*}%%\ *}%%,*}
   	 ${${${(z)${(@M)${(f)"$(cat ${HOME}/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*[*?]*}}
   	 ${${${(z)${(@M)${(f)"$(cat ${HOME}/.ssh/cfg/* 2>/dev/null)"}:#Host *}#Host }:#*[*?]*}}
   	 ${(s: :)${(ps:\t:)${${(f)~~"$(cat /etc/hosts 2>/dev/null)"}%%\#*}#*[[:blank:]]}}
    )'

	zstyle ':completion:*:sudo::' environ PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH:/opt/bin" HOME="${EPREFIX}/root"

	zstyle ':completion:*' use-cache on
    zstyle ':completion::complete:*' '\\'
    zstyle ':completion::complete:*' cache-path "${HOME}/.zcompcache"
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion:incremental:*' completer _complete _correct
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
    zstyle ':completion:*:expand:*' tag-order all-expansions
	zstyle ':completion:*:matches' group yes
    zstyle ':completion:*:match:*' original only
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:options' description yes
    zstyle ':completion:predict:*' completer _complete
    zstyle ':completion::prefix-1:*' completer _complete
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    zstyle ':completion:*' list-dirs-first true
    zstyle ':completion:*' menu true select
    zstyle ':completion:*:matches' group true
    zstyle ':completion:*' group-name ''

    _force_rehash() { (( CURRENT == 1 )) && rehash; return 1 }
    zstyle ':completion:::::' completer _force_rehash \
    _expand \
    _complete \
    _prefix \
    _ignored \
    _approximate \
    zstyle ':completion:*'    completer _force_rehash \
    _complete \
    _ignored \
    _prefix \
    _approximate \

}

source $ZSH/oh-my-zsh.sh
