# https://github.com/saesh/base16-fish/blob/master/functions/base16-tomorrow-night.fish
set -U fish_color_autosuggestion 373b41
set -U fish_color_cancel -r
set -U fish_color_command green #white
set -U fish_color_comment 373b41
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end brblack #blue
set -U fish_color_error red
set -U fish_color_escape yellow #green
set -U fish_color_history_current --bold
set -U fish_color_host normal
set -U fish_color_match --background=brblue
set -U fish_color_normal normal
set -U fish_color_operator blue #green
set -U fish_color_param b4b7b4
set -U fish_color_quote yellow #brblack
set -U fish_color_redirection cyan
set -U fish_color_search_match bryellow --background=373b41
set -U fish_color_selection white --bold --background=373b41
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path --underline
set -U fish_pager_color_completion normal
set -U fish_pager_color_description yellow --dim
set -U fish_pager_color_prefix white --bold #--underline
set -U fish_pager_color_progress brwhite --background=cyan

# Scheme name: Tomorrow Night
# Scheme system: base16
# Scheme author: Chris Kempson (http://chriskempson.com)
# Template author: Tinted Theming (https://github.com/tinted-theming)

set -l color00 '#1d1f21'
set -l color01 '#282a2e'
set -l color02 '#373b41'
set -l color03 '#969896'
set -l color04 '#b4b7b4'
set -l color05 '#c5c8c6'
set -l color06 '#e0e0e0'
set -l color07 '#ffffff'
set -l color08 '#cc6666'
set -l color09 '#de935f'
set -l color0A '#f0c674'
set -l color0B '#b5bd68'
set -l color0C '#8abeb7'
set -l color0D '#81a2be'
set -l color0E '#b294bb'
set -l color0F '#a3685a'

set -l FZF_NON_COLOR_OPTS

for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" $arg
        set -a FZF_NON_COLOR_OPTS $arg
    end
end

set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

# PAGE
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
