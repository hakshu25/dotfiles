# by hakshu

function peco_git_checkout
   set -l branch (git branch -a --format='%(refname)' | string match -v 'refs/remotes/*/HEAD' | string replace -r '^refs/(heads|remotes)/' '' | peco)
   if test -n "$branch"
       if git show-ref --verify --quiet refs/remotes/$branch
           # origin/feat/foo -> track it as local feat/foo
           git switch --track $branch
       else
           git switch $branch
       end
   end
   commandline -f repaint
end
