export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--layout=reverse'

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
