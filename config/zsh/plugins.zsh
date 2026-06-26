#####################
### zinit plugins ###
#####################
zinit light zsh-users/zsh-completions
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light zdharma-continuum/fast-syntax-highlighting

function zvm_after_init() {
	bindkey '^R' fzf-history-widget
	bindkey '^F' fzf-file-widget
	bindkey '^p' history-search-backward
	bindkey '^n' history-search-forward
	eval "$(zoxide init --cmd cd zsh)"
	compdef _cd_zoxide cd
	compdef _vim_zoxide nvim vim vi
}

# ember: muted grey ghost text for autosuggestions (base03)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6f655a'
