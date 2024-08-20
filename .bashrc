#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

alias cls='clear'
alias reload='source ~/.bashrc'
alias end='shutdown now'
alias ..='cd ..'
alias ...='cd ../..'

# git
alias clone='git clone --depth=1'
alias deps='git submodule update --init --recursive --depth 1 --force'

# pacman
alias update='sudo pacman -Syu'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias info='pacman -Si'
alias list='pacman -Qe'
alias cleanup='sudo pacman -Rns $(pacman -Qdtq)'
alias upgrade='sudo pacman -Syyu'
alias keyfix='sudo pacman-key --init && sudo pacman-key --populate archlinux'

export EDITOR=/usr/bin/micro
export TERMINAL=/usr/bin/alacritty

dl() {
    if [ -z "$1" ]; then
        echo "Usage: dl <URL> [filename]"
        return 1
    fi

    local url="$1"
    local filename="$2"

    if [ -z "$filename" ]; then
        wget --progress=bar:force -c "$url"
    else
        wget --progress=bar:force -c -O "$filename" "$url"
    fi
}

extract() {
    if [ -z "$1" ]; then
        echo "Usage: extract <archive_file>"
        return 1
    fi

    local file="$1"
    local extension="${file##*.}"

    case "$extension" in
        tar)
            tar -xf "$file"
            ;;
        gz | tgz)
            tar -xzf "$file"
            ;;
        bz2 | tbz2)
            tar -xjf "$file"
            ;;
        xz | txz)
            tar -xJf "$file"
            ;;
        zip)
            unzip "$file"
            ;;
        7z)
            7z x "$file"
            ;;
        *)
            echo "Unsupported file type: $extension"
            return 1
            ;;
    esac
}

alias ext='extract'

# Set the PS1 variable
# PS1='[\u@\h \W]\$ '

# https://gist.github.com/rchowe/1727301s
PS1='$(git branch &>/dev/null; if [ $? -eq 0 ]; then \
echo "\[\e[1m\]\u@\h\[\e[0m\]: \w [\[\e[34m\]$(git branch | grep ^* | sed s/\*\ //)\[\e[0m\]\
$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; if [ "$?" -ne "0" ]; then \
echo "\[\e[1;31m\]*\[\e[0m\]"; fi)] \$ "; else \
echo "\[\e[1m\]\u@\h\[\e[0m\]: \w \$ "; fi )'

eval "$(zoxide init bash)"

export PATH="~/.cargo/bin:$PATH"
