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

    zoxide init fish | source
end
