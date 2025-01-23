#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export MICRO_TRUECOLOR=0
export TERM=xterm-256color
export EDITOR=/usr/bin/micro
export COLORTERM=truecolor
export TERMINAL=/usr/bin/alacritty
export PAGER=less
export BROWSER=chromium
export PATH="~/my_msvc/bin/:~/.cargo/bin:$PATH"

# sudo archlinux-java set java-17-openjdk
# sudo archlinux-java set java-11-openjdk
# sudo archlinux-java set java-8-openjdk/jre
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export ANDROID_SDK_ROOT=~/Android
export ANDROID_NDK_HOME=~/Android/ndk

# if [[ -n "$PS1" && -z "$SCREEN" && -z "$DISPLAY" ]]; then
#     echo -n "Would you like to switch to i3? (Y/n) "
#     read -r response
#     if [[ "$response" =~ ^[Nn]$ ]]; then
#         return
#     fi
# 
#     echo "Starting i3..."
#     if [[ ! -f ~/.xinitrc ]]; then
#         exec startx i3
#     else
#         exec startx
#     fi
# fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/ikos3k/.lmstudio/bin"
