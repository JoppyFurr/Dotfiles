if status is-interactive

    # Terminal Colour utility function, based on base16 scripts
    function base16_put
        printf '\033]4;%d;rgb:%s\033\\' $argv
    end

    function base16_put_var
        printf '\033]%d;rgb:%s\033\\' $argv
    end

    # For now, just brighten up the default text colour.
    base16_put_var 10 d0/d0/d0 # Default foreground text

    # Changing these colours gets messy. Some programs expect particular
    # properties and try to compensate for them. Eg, htop uses bold text
    # for the blue in its bar graphs, expecting blue to be darker than
    # the other colours.

    # base16_put  0 00/00/00 # Black
    # base16_put  1 ff/5f/55 # Red
    # base16_put  2 95/e4/54 # Green
    # base16_put  3 d5/d9/87 # Yellow
    # base16_put  4 88/b8/f6 # Blue
    # base16_put  5 d7/87/ff # Magenta
    # base16_put  6 88/f2/f5 # Cyan
    # base16_put  7 e3/e0/d7 # White
    # base16_put  8 55/4d/4b # Bright black
    # base16_put  9 ff/5f/55 # Bright red
    # base16_put 10 95/e4/54 # Bright green
    # base16_put 11 d5/d9/87 # Bright yellow
    # base16_put 12 88/b8/f6 # Bright blue
    # base16_put 13 d7/87/ff # Bright magenta
    # base16_put 14 88/f2/f5 # Bright cyan
    # base16_put 15 ff/ff/ff # Bright white

    # Prompt
    function fish_prompt
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
        set -l normal (set_color normal)
        set -q fish_color_status
        or set -g fish_color_status red

        # Use '#' for root.
        set -l suffix '%'
        if functions -q fish_is_root_user; and fish_is_root_user
            set suffix '#'
        end

        # Write pipestatus
        # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
        set -l bold_flag --bold
        set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
        if test $__fish_prompt_status_generation = $status_generation
            set bold_flag
        end
        set __fish_prompt_status_generation $status_generation
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color $bold_flag $fish_color_status)
        set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        echo -n -s (prompt_login) $normal (fish_vcs_prompt) $normal " "$prompt_status " " $suffix " "
    end

    function fish_right_prompt
        echo -n -s (set_color $fish_color_cwd) (prompt_pwd)
    end

    # Abbreviations
    abbr --add gerp grep
    abbr --add sl ls
    abbr --add vi nvim

    # Environment fixes
    set -x LESSCHARSET "utf-8"

end
