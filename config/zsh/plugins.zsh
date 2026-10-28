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
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$P_BASE03_HEX"

# Gruber Darker faces: bold yellow keywords and builtins, niagara function names,
# green strings, quartz constants and options, brown comments, fg+1 variables.
FAST_HIGHLIGHT_STYLES[reserved-word]="fg=$P_BASE0A_HEX,bold"
FAST_HIGHLIGHT_STYLES[builtin]="fg=$P_BASE0A_HEX,bold"
FAST_HIGHLIGHT_STYLES[precommand]="fg=$P_BASE0A_HEX,bold"
FAST_HIGHLIGHT_STYLES[subcommand]="fg=$P_BASE0D_HEX"
FAST_HIGHLIGHT_STYLES[command]="fg=$P_BASE0D_HEX"
FAST_HIGHLIGHT_STYLES[function]="fg=$P_BASE0D_HEX"
FAST_HIGHLIGHT_STYLES[alias]="fg=$P_BASE0D_HEX"
FAST_HIGHLIGHT_STYLES[suffix-alias]="fg=$P_BASE0D_HEX"
FAST_HIGHLIGHT_STYLES[hashed-command]="fg=$P_BASE0D_HEX"
FAST_HIGHLIGHT_STYLES[unknown-token]="fg=$P_BASE08_HEX,bold"
FAST_HIGHLIGHT_STYLES[path]="fg=$P_BASE05_HEX"
FAST_HIGHLIGHT_STYLES[path-to-dir]="fg=$P_BASE05_HEX,underline"
FAST_HIGHLIGHT_STYLES[single-hyphen-option]="fg=$P_BASE0C_HEX"
FAST_HIGHLIGHT_STYLES[double-hyphen-option]="fg=$P_BASE0C_HEX"
FAST_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$P_BASE0B_HEX"
FAST_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$P_BASE0B_HEX"
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$P_BASE0B_HEX"
FAST_HIGHLIGHT_STYLES[back-or-dollar-double-quoted-argument]="fg=$P_BASE09_HEX"
FAST_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=$P_BASE09_HEX"
FAST_HIGHLIGHT_STYLES[variable]="fg=$P_BASE06_HEX"
FAST_HIGHLIGHT_STYLES[comment]="fg=$P_BASE09_HEX"
FAST_HIGHLIGHT_STYLES[globbing]="fg=$P_BASE0C_HEX"
FAST_HIGHLIGHT_STYLES[history-expansion]="fg=$P_BASE0C_HEX"
FAST_HIGHLIGHT_STYLES[single-sq-bracket]="fg=$P_BASE04_HEX"
FAST_HIGHLIGHT_STYLES[double-sq-bracket]="fg=$P_BASE04_HEX"
FAST_HIGHLIGHT_STYLES[double-paren]="fg=$P_BASE04_HEX"
FAST_HIGHLIGHT_STYLES[assign-array-bracket]="fg=$P_BASE04_HEX"
FAST_HIGHLIGHT_STYLES[paired-bracket]="bg=$P_BASE02_HEX"
FAST_HIGHLIGHT_STYLES[bracket-level-1]="fg=$P_BASE04_HEX"
FAST_HIGHLIGHT_STYLES[bracket-level-2]="fg=$P_BASE04_HEX"
FAST_HIGHLIGHT_STYLES[bracket-level-3]="fg=$P_BASE04_HEX"
FAST_HIGHLIGHT_STYLES[mathnum]="fg=$P_BASE0C_HEX"
FAST_HIGHLIGHT_STYLES[for-loop-number]="fg=$P_BASE0C_HEX"
FAST_HIGHLIGHT_STYLES[matherr]="fg=$P_BASE08_HEX"
FAST_HIGHLIGHT_STYLES[incorrect-subtle]="fg=$P_BASE08_HEX"
