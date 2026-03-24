# Checks out a branch selected via fzf, ordered by most recently used branches.
gcob() {
  local branch
  branch=$(git branch --sort=-committerdate | fzf --height=40% --reverse) || return
  git checkout "$(sed 's/^[* ]*//' <<< "$branch")"
}

# Same as above, but includes remote branches.
gcorb() {
  local branch
  branch=$(git branch --all --sort=-committerdate | grep -v HEAD | fzf --height=40% --reverse) || return
  git checkout "$(sed 's|^[* ]*||; s|remotes/[^/]*/||' <<< "$branch")"
}
