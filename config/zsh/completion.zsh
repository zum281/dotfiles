###################
### COMPLETIONS ###
###################

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q
_comp_options+=(globdots) # include hidden files

# uv completion (deferred: 6800-line script parsed after first prompt, not at startup)
autoload -Uz add-zsh-hook
_load_uv_comp() {
	eval "$(uv generate-shell-completion zsh)"
	add-zsh-hook -d precmd _load_uv_comp
}
add-zsh-hook precmd _load_uv_comp

##########################
### Completion styling ###
##########################

# case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# enable colors for completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# disable default zsh completion menu (replaced by fzf)
zstyle ':completion:*' menu no

zstyle ':fzf-tab:*' use-fzf-default-opts yes

# enable preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --all --grid --icons=always $realpath'

# have previews work with zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --all --grid --icons=always $realpath'
zstyle ':fzf-tab:complete:(nvim|vim|vi):*' fzf-preview 'bat -n --color=always $realpath 2>/dev/null || eza --color=always --all --grid --icons=always $realpath'
zstyle ':fzf-tab:complete:(cd|nvim|vim|vi):*' query-string input

_fzf_zoxide_dirs() {
	local -a zdirs
	zdirs=(${(f)"$(zoxide query --list 2>/dev/null)"})
	(( $#zdirs )) && compadd -M 'l:|=* r:|=*' -V zoxide-dirs -a zdirs
}

_cd_zoxide()  { _cd;  _fzf_zoxide_dirs }
_vim_zoxide() { _vim; _fzf_zoxide_dirs }

zstyle ':fzf-tab:complete:git-(checkout|switch):*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show $word | delta ;;
	*) git log --oneline --color=always $word ;;
	esac'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-branch:*' fzf-preview 'git log --oneline --color=always $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show $word ;;
	*) git show $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-(log|rebase|cherry-pick):*' fzf-preview 'git show $word | delta'
zstyle ':fzf-tab:complete:git-stash:*' fzf-preview 'git stash show -p $word | delta'

zstyle ':fzf-tab:complete:(nvim|vi|bat|cat):*' fzf-preview 'bat -n --color=always $realpath 2>/dev/null || eza --tree --color=always $realpath'
zstyle ':fzf-tab:complete:ssh:*' fzf-preview 'dig +short $word'
zstyle ':fzf-tab:complete:man:*' fzf-preview 'man $word 2>/dev/null | col -bx | bat -l man -p --color=always'

zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview 'ps -p $word -o command='
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:docker-(logs|exec|stop|start|restart|attach|rm|inspect|cp):*' fzf-preview \
	'docker inspect --format "{{.Name}} · {{.State.Status}} · {{.Config.Image}}" $word 2>/dev/null || docker ps'

zstyle ':fzf-tab:complete:npm:*' fzf-preview 'jq -r --arg k "$word" ".scripts[\$k] // empty" package.json 2>/dev/null'
zstyle ':fzf-tab:complete:(brew|brew-install|brew-info):*' fzf-preview 'brew info $word 2>/dev/null'
