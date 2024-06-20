function dbx --description 'Distrobox with fish shell'
  set -f SHELL /usr/bin/fish
  distrobox $argv
end
