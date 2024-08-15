#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

HOME_FILES=(
    ".bash_profile"
    ".tmux.conf"
    ".xinitrc"
    ".Xresources"
    ".config/i3/config"
    ".config/xfce4/xfconf/xfce-perchannel-xml/xfce4-terminal.xml"
    ".config/alacritty/alacritty.toml"
    ".config/wezterm/wezterm.lua"
    ".config/xfce4/helpers.rc"
    ".config/zed/settings.json"
    ".config/micro/settings.json"
    ".config/pcmanfm/default/pcmanfm.conf"
)

SYSTEM_FILES=(
    "/etc/i3status.conf"
    "/usr/bin/i3-sensible-terminal"
    "/usr/bin/i3-sensible-editor"
)

backup_dotfiles() {
    local SHOW_DIFFS=0
    if [[ "$1" == "-diff" ]]; then
        SHOW_DIFFS=1
    fi

    if [ -n "$SUDO_USER" ]; then
        USER_HOME=$(eval echo ~$SUDO_USER)
    else
        echo "SUDO_USER is not set. Exiting."
        exit 1
    fi

    echo "Backing up home directory dotfiles from $USER_HOME to $DOTFILES_DIR..."
    for FILE_PATTERN in "${HOME_FILES[@]}"; do
        for FILE in "$USER_HOME/$FILE_PATTERN"; do
            if [ -e "$FILE" ]; then
                RELATIVE_FILE="${FILE#$USER_HOME/}"
                echo "Backing up $RELATIVE_FILE to $DOTFILES_DIR"
                mkdir -p "$DOTFILES_DIR/$(dirname "$RELATIVE_FILE")"

                if [ "$SHOW_DIFFS" -eq 1 ] && [ -f "$DOTFILES_DIR/$RELATIVE_FILE" ]; then
                    if ! diff -q "$DOTFILES_DIR/$RELATIVE_FILE" "$FILE" >/dev/null; then
                        echo "Differences for $RELATIVE_FILE:"
                        diff -u --color=auto "$DOTFILES_DIR/$RELATIVE_FILE" "$FILE"
                    fi
                fi

                cp -r "$FILE" "$DOTFILES_DIR/$RELATIVE_FILE"
            else
                echo "No existing $FILE found in home directory."
            fi
        done
    done

    echo "Backing up system-wide configuration files to $DOTFILES_DIR..."
    for FILE in "${SYSTEM_FILES[@]}"; do
        if [ -f "$FILE" ]; then
            RELATIVE_PATH="${FILE#/}"
            echo "Backing up $FILE to $DOTFILES_DIR"
            mkdir -p "$DOTFILES_DIR/$(dirname "$RELATIVE_PATH")"

            if [ "$SHOW_DIFFS" -eq 1 ] && [ -f "$DOTFILES_DIR/$RELATIVE_PATH" ]; then
                if ! diff -q "$DOTFILES_DIR/$RELATIVE_PATH" "$FILE" >/dev/null; then
                    echo "Differences for $RELATIVE_PATH:"
                    diff -u --color=auto "$DOTFILES_DIR/$RELATIVE_PATH" "$FILE"
                fi
            fi

            cp "$FILE" "$DOTFILES_DIR/$RELATIVE_PATH"
        else
            echo "No existing $FILE found in the system."
        fi
    done
    echo "Backup complete!"
}

restore_dotfiles() {
    local SHOW_DIFFS=0
    local SAFE_MODE=0
    if [[ "$1" == "-diff" ]]; then
        SHOW_DIFFS=1
    elif [[ "$1" == "-safe" ]]; then
        SAFE_MODE=1
        SHOW_DIFFS=1
    fi

    if [ -n "$SUDO_USER" ]; then
        USER_HOME=$(eval echo ~$SUDO_USER)
    else
        echo "SUDO_USER is not set. Exiting."
        exit 1
    fi

    echo "Restoring home directory dotfiles from $DOTFILES_DIR to $USER_HOME..."
    for FILE_PATTERN in "${HOME_FILES[@]}"; do
        for FILE in "$DOTFILES_DIR/$FILE_PATTERN"; do
            if [ -e "$FILE" ]; then
                RELATIVE_FILE="${FILE#$DOTFILES_DIR/}"
                TARGET_FILE="$USER_HOME/$RELATIVE_FILE"

                if [ "$SHOW_DIFFS" -eq 1 ] && [ -f "$TARGET_FILE" ]; then
                    if ! diff -q "$TARGET_FILE" "$FILE" >/dev/null; then
                        echo "Differences for $RELATIVE_FILE:"
                        diff -u --color=auto "$TARGET_FILE" "$FILE"
                    fi
                fi

                if [ "$SAFE_MODE" -eq 1 ]; then
                    read -p "Do you want to restore $RELATIVE_FILE? [y/N] " answer
                    case "$answer" in
                        [yY][eE][sS]|[yY])
                            echo "Restoring $RELATIVE_FILE to $USER_HOME"
                            mkdir -p "$USER_HOME/$(dirname "$RELATIVE_FILE")"
                            cp -r "$FILE" "$TARGET_FILE"
                            ;;
                        *)
                            echo "Skipped restoring $RELATIVE_FILE"
                            ;;
                    esac
                else
                    echo "Restoring $RELATIVE_FILE to $USER_HOME"
                    mkdir -p "$USER_HOME/$(dirname "$RELATIVE_FILE")"
                    cp -r "$FILE" "$TARGET_FILE"
                fi
            else
                echo "No $FILE found in $DOTFILES_DIR."
            fi
        done
    done

    echo "Restoring system-wide configuration files from $DOTFILES_DIR..."
    for FILE in "${SYSTEM_FILES[@]}"; do
        RELATIVE_PATH="${FILE#/}"
        if [ -f "$DOTFILES_DIR/$RELATIVE_PATH" ]; then
           if [ "$SHOW_DIFFS" -eq 1 ] && [ -f "$FILE" ]; then
                if ! diff -q "$DOTFILES_DIR/$RELATIVE_PATH" "$FILE" >/dev/null; then
                    echo "Differences for $FILE:"
                    diff -u --color=auto "$DOTFILES_DIR/$RELATIVE_PATH" "$FILE"
                fi
            fi

            if [ "$SAFE_MODE" -eq 1 ]; then
                read -p "Do you want to restore $RELATIVE_PATH? [y/N] " answer
                case "$answer" in
                    [yY])
                        echo "Restoring $RELATIVE_PATH to $FILE"
                        mkdir -p "$(dirname "$FILE")"
                        cp "$DOTFILES_DIR/$RELATIVE_PATH" "$FILE"
                        ;;
                    *)
                        echo "Skipped restoring $RELATIVE_PATH"
                        ;;
                esac
            else
                echo "Restoring $RELATIVE_PATH to $FILE"
                mkdir -p "$(dirname "$FILE")"
                cp "$DOTFILES_DIR/$RELATIVE_PATH" "$FILE"
            fi
        else
            echo "No $RELATIVE_PATH found in $DOTFILES_DIR."
        fi
    done
    echo "Restore complete!"
}

if [ "$1" == "backup" ]; then
    backup_dotfiles "$2" # -diff
elif [ "$1" == "restore" ] && [ "$2" == "-diff" ]; then
    restore_dotfiles "-diff"
elif [ "$1" == "restore" ] && [ "$2" == "-safe" ]; then
    restore_dotfiles "-safe"
elif [ "$1" == "restore" ]; then
    restore_dotfiles
else
    echo "Usage: $0 <backup|restore [-safe]> [-diff]"
    echo " -diff  : Compare files and show differences during restore."
    echo " -safe  : Prompt for confirmation before restoring each file. Automatically shows diffs."
fi
