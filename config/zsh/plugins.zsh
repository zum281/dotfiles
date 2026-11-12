#####################
### zinit plugins ###
#####################
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit ice depth=1
zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1
zinit light zdharma-continuum/fast-syntax-highlighting

function zvm_after_init() {
	bindkey '^R' fzf-history-widget
	bindkey '^F' fzf-file-widget
	bindkey '^p' history-search-backward
	bindkey '^n' history-search-forward
	eval "$(zoxide init --cmd cd zsh)"
}
