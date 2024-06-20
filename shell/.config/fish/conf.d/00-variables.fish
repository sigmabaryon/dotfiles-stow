## (Github Dark Dimmed) Colors for Fish shell
#set -l comment brblack
#set -l selection 264f78
#
## Shell highlight groups
## (https://fishshell.com/docs/current/interactive.html#variables-color)
#
#set -g fish_color_normal brwhite  # Default text
#set -g fish_color_command blue # 'cd', 'ls', 'echo'
#set -g fish_color_keyword yellow # 'if'   NOTE: default = $fish_color_command
#set -g fish_color_quote brgreen  # "foo" in 'echo "foo"'
#set -g fish_color_error red  # incomplete / non-existent commands   NOTE: default = red
#set -g fish_color_param white # xvf in 'tar xvf', --all in 'ls --all'
#set -g fish_color_comment green # '# a comment' # Question: Where does default come from if not set?
#set -g fish_color_selection --background=$selection # Run 'fish_vi_key_bindings', type some text, <Esc> then 'v' to select text
#set -g fish_color_operator red  # * in 'ls ./*'
#set -g fish_color_autosuggestion brblack --italics # Appended virtual text, e.g. 'cd  ' displaying 'cd ~/some/path'
#set -g fish_color_search_match --background=$selection # TODO: How to trigger?
#
#set -g fish_pager_color_completion $fish_color_param # List of suggested items for 'ls <Tab>'
#set -g fish_pager_color_description brblue # (command) in list of commands for 'c<Tab>'
#set -g fish_pager_color_prefix bryellow --underline  # Leading 'c' in list of completions for 'c<Tab>'
#set -g fish_pager_color_progress brwhite  # '…and nn more rows' for 'c<Tab>'
#set -g fish_pager_color_selected_background --background=$selection # Cursor when <Tab>ing through 'ls <Tab>'

# Nightfox Color Palette
# Style: nightfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nightfox/nightfox.fish
set -l foreground cdcecf
set -l selection 2b3b51
set -l comment 738091
set -l red c94f6d
set -l orange f4a261
set -l yellow dbc074
set -l green 81b29a
set -l purple 9d79d6
set -l cyan 63cdcf
set -l pink d67ad2

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

# FZF
set -gax FZF_DEFAULT_OPTS ' --color=fg:#cdcecf,bg:#192330,hl:#dfdfe0 --color=fg+:#ffffff,bg+:#131a24,hl+:#719cdb --color=info:#e0c989,prompt:#7ad5d6,pointer:#d67ad2 --color=marker:#8ebaa4,spinner:#d16983,header:#575860'

# PAGE
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
