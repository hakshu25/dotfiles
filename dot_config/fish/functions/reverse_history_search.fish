function reverse_history_search
  history | fzf --no-sort --height 10 | read -l command
  if test $command
    commandline -rb $command
  end
end
