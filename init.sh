#!/bin/bash


home_configs=('zshrc'
              'vimrc'
              'tmux.conf'
              'scripts')


function make_link () {
    if ! $2; then
        ln -s "$PWD/$1" "$HOME/.$1"
    else
        ln -s "$PWD/$1" "$HOME/.config/$1"
    fi
}


function start_this() {
    for c in ${home_configs[@]}; do
        echo "$HOME/$c"
        if [ -f "$HOME/.$c" ]; then
            echo "$c -- File removed!"
            rm "$HOME/.$c"
        fi
        if [ -L "$HOME/.$c" ]; then
            echo "$c -- Link removed!"
            rm "$HOME/.$c"
        fi
        if [ -d "$HOME/.$c" ]; then
            echo "$c -- Dir removed!"
            rm -Rf "$HOME/.$c"
        fi
        make_link $c false
    done
}

dialog --title "Config pusher" --yesno "Your existing configs has be delited. Do you wish to begin?" 7 60
response=$?
clear
case $response in
    0) start_this ;;
    1) exit ;;
esac

#ln -s ./zshrc     ~/.zshrc
#ln -s ./vimrc     ~/.vimrc
#ln -s ./tmux.conf ~/.tmux.conf
#ln -s ./i3/config ~/.config/i3/config
#ln -s ./scripts   ~/.scripts
#ln -s ./polybar   ~/.config/polybar
