if status is-interactive
  # conflicts with fzf
  # set -g fish_key_bindings fish_vi_key_bindings

  if [ "$fish_key_bindings" = fish_vi_key_bindings ];
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
  else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
  end

  if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
      set -p PATH ~/.local/bin
    end
  end

  if test -d ~/.local/share/bob/nvim-bin
    if not contains -- ~/.local/share/bob/nvim-bin $PATH
      set -p PATH ~/.local/share/bob/nvim-bin
    end
  end

  if test -d ~/.local/share/nvim/mason/bin
    if not contains -- ~/.local/share/nvim/mason/bin $PATH
      set -p PATH ~/.local/share/nvim/mason/bin
    end
  end

  starship init fish | source
  zoxide init --cmd cd fish | source
end

set -gx GOPATH $HOME/go; set -gx GOROOT $HOME/.go; set -gx PATH $GOPATH/bin $PATH; # g-install: do NOT edit, see https://github.com/stefanmaric/g
