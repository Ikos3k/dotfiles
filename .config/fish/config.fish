if status is-interactive
    set -g fish_greeting "$(fortune -as | cowsay -r)"

    # Colorscheme: Old School
    set -U fish_color_normal normal
    set -U fish_color_command 00FF00
    set -U fish_color_quote 44FF44
    set -U fish_color_redirection 7BFF7B
    set -U fish_color_end FF7B7B
    set -U fish_color_error A40000
    set -U fish_color_param 30BE30
    set -U fish_color_comment 30BE30
    set -U fish_color_match --background=brblue
    set -U fish_color_selection white --bold --background=brblack
    set -U fish_color_search_match bryellow --background=brblack
    set -U fish_color_history_current --bold
    set -U fish_color_operator 00a6b2
    set -U fish_color_escape 00a6b2
    set -U fish_color_cwd green
    set -U fish_color_cwd_root red
    set -U fish_color_valid_path --underline
    set -U fish_color_autosuggestion 777777
    set -U fish_color_user brgreen
    set -U fish_color_host normal
    set -U fish_color_cancel --reverse
    set -U fish_pager_color_prefix normal --bold --underline
    set -U fish_pager_color_progress brwhite --background=cyan
    set -U fish_pager_color_completion normal
    set -U fish_pager_color_description B3A06D
    set -U fish_pager_color_selected_background --background=brblack
    set -U fish_color_keyword
    set -U fish_pager_color_selected_prefix
    set -U fish_pager_color_background
    set -U fish_pager_color_secondary_background
    set -U fish_pager_color_selected_completion
    set -U fish_pager_color_secondary_completion
    set -U fish_pager_color_selected_description
    set -U fish_color_option
    set -U fish_pager_color_secondary_prefix
    set -U fish_color_host_remote
    set -U fish_pager_color_secondary_description

    alias make-python-env="python3 -m venv my_env"
    alias activate-env="source my_env/bin/activate.fish"
    alias cls="clear"
    alias feh='feh --scale-down'

    function ips
        printf "%s\t%s\t%s\n" "NAME" "KIND" "IP ADDRESS"
        ip -o addr show | while read -l line
            set name (echo $line | awk "{print \$2}")
            set kind (echo $line | awk "{print \$3}")
            set ip (echo $line | awk "{print \$4}" | sed "s/\/.*//g")
            printf "%s\t%s\t%s\n" "$name" "$kind" "$ip"
        end
    end
    
    function sinks
        printf "%s\t%s\n" "TYPE" "DEVICE NAME"
        pactl list short sinks | awk "/alsa_output|sink/ {printf \"OUTPUT\t%s\\n\", \$2}"
        pactl list short sources | awk "/alsa_input|source/ {printf \"INPUT\t%s\\n\", \$2}"
    end

    zoxide init fish | source
end
