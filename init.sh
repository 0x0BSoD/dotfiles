#!/usr/bin/env bash
PM=0
ZSH=0

pm=("apt-get" "pacman" "brew" "yum" "yast")
declare -A conf_f
declare -A conf_d

conf_f["zsh"]="zshrc"
conf_f["vim"]="vimrc"
conf_f["tmux"]="tmux.conf"

conf_d["i3"]=".config/i3"
conf_d["i3blocks"]=".config/i3blocks"
#conf_d["polybar"]=".config/polybar"

function make_links() {
    echo "Linking #########################"
     for c in "${!conf_f[@]}"; do
        which ${c} > /dev/null
        rc=$?
        if [[ ${rc} -eq 0 ]]; then
            CFG_PATH="$HOME/.${conf_f[$c]}"
            echo "======= ${CFG_PATH} ============"
            if [[ -f ${CFG_PATH} ]]; then
                echo "${CFG_PATH} -- File removed!"
                rm "${CFG_PATH}"
            fi
            if [[ -L ${CFG_PATH} ]]; then
                echo "${CFG_PATH} -- Link removed!"
                rm ${CFG_PATH}
            fi
            ln -s "$PWD/${c}/${conf_f[$c]}" ${CFG_PATH}
        fi
     done

     for c in "${!conf_d[@]}"; do
        which ${c} > /dev/null
        rc=$?
        if [[ ${rc} -eq 0 ]]; then
            CFG_PATH="$HOME/${conf_d[$c]}"
            echo "======= ${CFG_PATH} ============"
            if [[ -d ${CFG_PATH} ]]; then
                echo "${CFG_PATH} -- Dir removed!"
                rm -Rf ${CFG_PATH}
            fi
            ln -s "$PWD/${c}" ${CFG_PATH}
        fi
     done

     which zsh > /dev/null
     rc=$?
     if [[ ${rc} -eq 0 ]]; then
         echo "Add customs to oh-my-zsh #########################"
         if [[ -d $HOME/.oh-my-zsh/custom ]]; then
             echo "$HOME/.oh-my-zsh/custom -- Dir removed!"
             rm -Rf $HOME/.oh-my-zsh/custom
         fi
         ln -s "$PWD/ohmyzsh/custom" "$HOME/.oh-my-zsh/custom"
     fi


}

echo "Package manager #########################"
 for c in ${pm[@]}; do
    which ${c} > /dev/null
    rc=$?
    if [[ ${rc} -eq 0 ]]; then
        echo "[x] Is ${c}"
        if [[ $c != "pacman" ]]; then
            PM="${c} install"
        else
            PM="${c} -S"
        fi
        break
    fi
 done

if $1 != "silent"
then
    which dialog > /dev/null
    rc=$?
    if [[ ${rc} -eq 1 ]]; then
        echo "Bash dialog === Not Installed"
        command="${PM} dialog"
        echo "[x] run: ${command}"
        ${command}
    fi


    dialog --title "Config pusher" --yesno "Your existing configs has be delited. Do you wish to begin?" 7 60
    response=$?
    clear
    case ${response} in
        0) make_links ;;
        1) exit ;;
    esac
else
   make_links
fi

#start_this
#ln -s ./zshrc     ~/.zshrc
#ln -s ./vimrc     ~/.vimrc
#ln -s ./tmux.conf ~/.tmux.conf
#ln -s ./i3/config ~/.config/i3/config
#ln -s ./scripts   ~/.scripts
#ln -s ./polybar   ~/.config/polybar
