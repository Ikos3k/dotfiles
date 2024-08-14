#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -n "$PS1" && -z "$SCREEN" && -z "$DISPLAY" ]]; then
    echo -n "Would you like to switch to i3? (Y/n) "
    read -r response
    if [[ "$response" =~ ^[Nn]$ ]]; then
        return
    fi

    echo "Starting i3..."
    if [[ ! -f ~/.xinitrc ]]; then
        exec startx i3
    else
        exec startx
    fi
fi
