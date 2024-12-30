#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# fastfetch
fortune -as | cowsay -r

alias rm='rm -i'
alias ls='ls --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -alF'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias feh='feh --scale-down'

alias disks='lsblk -e7 -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT | while read -r line; do \
  disk=$(echo $line | awk "{print \$1}"); \
  if [[ "$disk" =~ ^sd[a-z]$ ]]; then \
    model=$(udevadm info --query=all --name=/dev/$disk | grep "ID_MODEL=" | cut -d "=" -f 2); \
    interface=$(udevadm info --query=all --name=/dev/$disk | grep "ID_BUS=" | cut -d "=" -f 2); \
    echo "$line $model $interface"; \
  else \
    echo "$line"; \
  fi; \
done'

# alias disks2='for disk in /dev/sd*; do \
#   if [ -e "$disk" ]; then \
#     echo "Disk: $disk"; \
#     sudo parted $disk print; \
#   fi; \
# done'

alias ips='printf "%s\t%s\t%s\n" "NAME" "KIND" "IP ADDRESS"; ip -o addr show | while read -r line; do \
  name=$(echo $line | awk "{print \$2}"); \
  kind=$(echo $line | awk "{print \$3}"); \
  ip=$(echo $line | awk "{print \$4}" | sed "s/\/.*//g"); \
  printf "%s\t%s\t%s\n" "$name" "$kind" "$ip"; \
done'

alias sinks='
  printf "%s\t%s\n" "TYPE" "DEVICE NAME";
  pactl list short sinks | awk "/alsa_output|sink/ {printf \"OUTPUT\t%s\\n\", \$2}";
  pactl list short sources | awk "/alsa_input|source/ {printf \"INPUT\t%s\\n\", \$2}"
'

alias qr='qrencode -t ANSI -o - '

alias snaps='snap list'
alias files='ls | wc -l'

alias cls='clear'
alias reload='source ~/.bashrc'
alias end='systemctl poweroff'
alias ..='cd ..'
alias ...='cd ../..'
alias back='cd -'
alias ??='echo $?'

alias myip="curl ipinfo.io/ip; echo"
alias localip="ip a | grep inet | grep -v inet6 | grep -v '127.0.0.1' | awk '{print \$2}' | cut -d/ -f1"

alias cleanupall='sudo pacman -Sc && yay -Sc && sudo journalctl --vacuum-time=2weeks'
alias fs='stat --printf="%s bytes\n"'
alias wipehist='history -c && history -w'

# git
alias g='git'
alias clonerec='git clone --depth=1 --recurse-submodules --shallow-submodules'
alias clone='git clone --depth=1'
alias deps='git submodule update --init --recursive --depth 1 --force'
alias pull='git pull'
alias fetch='git fetch'
alias fetch-pulls='function pull-req() { git fetch --depth 1 origin "refs/pull/*:refs/remotes/origin/pull/*"; }; pull-req'
alias fetch-open-pulls='function pull-oreq() { git fetch --depth 1 origin "refs/pull/*:refs/remotes/origin/pull/*"; }; pull-oreq'

# pacman
alias i='sudo pacman -S'
alias ifile='sudo pacman -U'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias info='pacman -Si'
alias list='pacman -Qe'
alias cleanup='sudo pacman -Rns $(pacman -Qdtq)'
alias update='sudo pacman -Syu'
alias upgrade='sudo pacman -Syyu'
alias keyfix='sudo pacman-key --init && sudo pacman-key --populate archlinux'

alias powoff="sudo udisksctl power-off -b" 
alias cmake-build="mkdir build && cd build && cmake .. && cmake --build . -j12"

alias make-python-env="python3 -m venv my_env"
alias activate-env="source my_env/bin/activate"

mkv_to_mp4() {
    if [[ -z "$1" ]]; then
        echo "Usage: convert_mkv_to_mp4 <input_file.mkv>"
        return 1
    fi

    local input_file="$1"
    local output_file="${input_file%.*}.mp4"

    ffmpeg -i "$input_file" -c copy "$output_file"
    
    echo "Conversion complete: $output_file"
}

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
        AppxBundle)
            unzip "$file"
            ;;
        appx)
            unzip "$file"
            ;;
        7z)
            7z x "$file"
            ;;
        iso)
            7z x "$file"
            ;;
        rar)
            unrar x "$file"
            ;;
        *)
            echo "Unsupported file type: $extension"
            return 1
            ;;
    esac
}

alias ext='extract'

hist() {
    if [ -z "$1" ]; then
        echo "Usage: hist <search_term>"
        return 1
    fi

    history | grep "$1"
}

mkcd() {
    if [ -z "$1" ]; then
        echo "Usage: mkcd <directory_name>"
        return 1
    fi

    mkdir -p "$1" && cd "$1"
}

choose_shell() {
    echo "Available shells:"
    cat /etc/shells
    echo
    read -p "Enter the full path of the shell you want to set as default: " selected_shell
    if grep -Fxq "$selected_shell" /etc/shells; then
        chsh -s "$selected_shell"
        echo "Default shell changed to $selected_shell."
    else
        echo "Error: The selected shell is not in /etc/shells."
    fi
}

get_last() {
    num_items=${1:-1}
    latest_items=$(ls -t | head -n "$num_items")
    if [ -n "$latest_items" ]; then
        echo "$latest_items"
    else
        echo "No files or directories found!"
    fi
}

mv_last() {
    latest_item=$(ls -t | head -n 1)
    if [ -n "$latest_item" ]; then
        mv "$latest_item" "$1"
        echo "Moved '$latest_item' to '$1'"
    else
        echo "No file or directory found to move!"
    fi
}

# Set the PS1 variable
# PS1='[\u@\h \W]\$ '

# https://gist.github.com/rchowe/1727301
# PS1='$(git branch &>/dev/null; if [ $? -eq 0 ]; then \
# echo "\[\e[1m\]\u@\h\[\e[0m\]: \w [\[\e[34m\]$(git branch | grep ^* | sed s/\*\ //)\[\e[0m\]\
# $(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; if [ "$?" -ne "0" ]; then \
# echo "\[\e[1;31m\]*\[\e[0m\]"; fi)] \$ "; else \
# echo "\[\e[1m\]\u@\h\[\e[0m\]: \w \$ "; fi )'

export PS1='$(git branch &>/dev/null; 
if [ $? -eq 0 ]; then 
    # Git repository detected
    BRANCH=$(git branch | grep ^* | sed "s/\* //")
    # Check if there are any commits
    if git rev-parse --verify HEAD &>/dev/null; then
        # There are commits
        COMMIT=$(git rev-parse --short HEAD)
    else
        # No commits yet
        COMMIT="no commits"
    fi
    STATUS=$(git status)

    # Start the prompt with user@host and current working directory
    PS1_PROMPT="\[\e[1m\]\u@\h\[\e[0m\]: \w "

    # Display the branch in blue
    PS1_PROMPT+="[\[\e[34m\]$BRANCH\[\e[0m\]"

    # Check if there are uncommitted changes, display * in red if true
    if echo "$STATUS" | grep -q "nothing to commit"; then
        PS1_PROMPT+="]"
    else
        PS1_PROMPT+="\[\e[1;31m\]*\[\e[0m\]]"
    fi

    PS1_PROMPT+=" [\[\e[1;32m\]$COMMIT\[\e[0m\]]"

    PS1_PROMPT+=" \$ "
    echo "$PS1_PROMPT"
else 
    # Not in a git repository
    echo "\[\e[1m\]\u@\h\[\e[0m\]: \w \$ "
fi)'

eval "$(zoxide init bash)"
