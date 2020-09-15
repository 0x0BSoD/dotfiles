#!/usr/bin/env bash
PM=0
ZSH=0

pm=("apt-get" "pacman" "brew" "yum" "yast")
declare -A conf_f
# declare -a conf_d

conf_f["zsh"]="zshrc"
conf_f["vim"]="vimrc"
conf_f["tmux"]="tmux.conf"

function make_links() {
    for c in "${!conf_f[@]}"; do
        # echo "$c ==> ${conf_f[$c]}"
        echo "=> Checking ${c}"
        which ${c} > /dev/null
        rc=$?
        if [[ ! ${rc} -eq 0 ]]; then
            command="${PM} ${c}"
            echo "[x] run: ${command}"
            ${command}
        else
            echo "[x] installed"
        fi

        echo "=> Linking ${conf_f[$c]}"
        CFG_PATH="$HOME/.${conf_f[$c]}"
        echo "config path is ${CFG_PATH}"
        if [[ -f ${CFG_PATH} ]]; then
            echo "${CFG_PATH} -- File removed!"
            rm "${CFG_PATH}"
        fi

        if [[ $c == "vim" ]]; then
            if [[ ! -d $HOME/.vim/bundle/Vundle.vim ]]; then 
                echo "Install Vundle"
                git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
                vim +PluginInstall +qall
            fi
        fi
        
        if [[ $c == "zsh" ]]; then
            if [[ ! -d $HOME/.oh-my-zsh ]]; then
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            fi
            ln -s "$PWD/${c}/${conf_f[$c]}" ${CFG_PATH}
            echo "link created"
            echo ""

            echo "Add custom dir link to oh-my-zsh"
            if [[ -d $HOME/.oh-my-zsh/custom ]]; then
                echo "$HOME/.oh-my-zsh/custom -- Dir removed!"
                rm -Rf $HOME/.oh-my-zsh/custom
            fi
        
            ln -s "$PWD/ohmyzsh/custom" "$HOME/.oh-my-zsh/custom"
            echo "link created"

            which fzf > /dev/null
            rc=$?
            if [[ ${rc} -eq 1 ]]; then
                echo "fzf === Not Installed"
                command="${PM} fzf"
                echo "[x] run: ${command}"
                ${command}
            fi

            which thefuck > /dev/null
            rc=$?
            if [[ ${rc} -eq 1 ]]; then
                echo "thefuck === Not Installed"
                command="${PM} thefuck"
                echo "[x] run: ${command}"
                ${command}
            fi

            if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
                echo "Install zsh-syntax-highlighting"
                git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            fi

            if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
                echo "Install zsh-autosuggestions"
                git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
            fi
        fi

        echo -e "+================+\n"
    done
}


echo "You bash version is $BASH_VERSION"
echo "If it less than 4 install newer version of bash and restart script"
echo "brew update && brew install bash"
echo ""

echo "=> Checking package manager"
for c in ${pm[@]}; do
    which ${c} > /dev/null
    rc=$?
    if [[ ${rc} -eq 0 ]]; then
        echo "[x] It's ${c}"
        if [[ $c != "pacman" ]]; then
            PM="${c} install"
        else
            PM="${c} -S"
        fi
        break
    fi
done
echo ""

if [[ $1 != "silent" ]]
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
