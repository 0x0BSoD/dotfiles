# Some vars for i3 and other
export PATH=$PATH:$HOME/.scripts
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="chromium"
export BLOCKSIZE=Mb
export KEYTIMEOUT=1

export ZSH=$HOME/.oh-my-zsh

unamestr=$(uname)

ZSH_THEME="agnoster"

if [[ $unamestr == "Darwin" ]]; then
    plugins=(
      git
      vi-mode
      npm
      brew
      nyan
      web-search
    )
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    plugins=(
      git
      zsh-syntax-highlighting
      archlinux
      vi-mode
      web-search
    )
fi

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

if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

# VI-mode tune
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
zle -N zle-keymap-select
# define right prompt, regardless of whether the theme defined it
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

alias grep='nocorrect grep --color=auto --exclude="*.pyc" --exclude-dir=".svn" --exclude-dir=".hg" --exclude-dir=".bzr" --exclude-dir=".git"';


if [[ $unamestr == "Darwin" ]]; then
   alias ls='ls -FGh'
   alias ll='ls -FGhl'
   alias la='ls -FGhlA'
   alias li='ls -FGhial'
   alias lsa='ls -FGhld .*'
else
   alias ls='ls -Fh --color=auto'
   alias ll='ls -Fhl --color=auto'
   alias la='ls -FhlA --color=auto'
   alias li='ls -Fhial --color=auto'
   alias lsa='ls -Fhld --color=auto .*'
fi

alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -I'

alias rehash="hash -r"

alias ga='git add -A'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'

# ----------------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------------

# Change directory to the current Finder directory
if [[ $unamestr == "Darwin" ]]; then
    cdf() {
        target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
        if [ "$target" != "" ]; then
          cd "$target"; pwd
        else
          echo 'No Finder window found' >&2
        fi
    }
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
}

function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
