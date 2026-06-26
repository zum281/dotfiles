#############################
### Bare-command pickers ###
#############################

git() {
	if [ -t 1 ] && [ $# -eq 1 ]; then
		case "$1" in
			switch|checkout)
				local b
				b=$(command git branch --all --format='%(refname:short)' | sed 's#^origin/##' | sort -u | fzf --preview 'git log --oneline --color=always {}') || return
				[ -n "$b" ] && command git "$1" "$b"
				return ;;
			add|restore)
				local action=$1 files
				files=$(command git -c color.status=always status --short | fzf --multi --ansi --nth 2.. \
					--preview 'echo {} | sed "s/^...//" | xargs -I% git diff -- % | delta' | sed 's/^...//')
				[ -n "$files" ] && echo "$files" | while IFS= read -r f; do command git "$action" "$f"; done
				return ;;
			log)
				command git log --oneline --color=always | fzf --ansi --no-sort \
					--preview 'git show --color=always {1} | delta' \
					--bind 'enter:execute(git show --color=always {1} | delta | less -R)'
				return ;;
		esac
	fi
	command git "$@"
}

rg() {
	if [ -t 1 ] && [ $# -eq 0 ]; then
		fzf --ansi --disabled --delimiter : \
			--bind 'start:reload:command rg --column --line-number --no-heading --color=always --smart-case ""' \
			--bind 'change:reload:command rg --column --line-number --no-heading --color=always --smart-case {q} || true' \
			--preview 'bat --color=always {1} --highlight-line {2}' \
			--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
			--bind 'enter:become(nvim {1} +{2})'
		return
	fi
	command rg "$@"
}

man() {
	if [ -t 1 ] && [ $# -eq 0 ]; then
		local p
		p=$(command man -k . 2>/dev/null | fzf --ansi \
			--preview 'echo {} | sed -E "s/\(.*//" | awk "{print \$1}" | xargs man 2>/dev/null | col -bx | bat -l man -p --color=always' \
			| sed -E 's/\(.*//' | awk '{print $1}') || return
		[ -n "$p" ] && command man "$p"
		return
	fi
	command man "$@"
}

kill() {
	if [ -t 1 ] && [ $# -eq 0 ]; then
		local pids
		pids=$(command ps aux | sed 1d | fzf --multi --header-lines=0 | awk '{print $2}') || return
		[ -n "$pids" ] && echo "$pids" | xargs kill
		return
	fi
	command kill "$@"
}

brew() {
	if [ -t 1 ] && [ $# -eq 0 ]; then
		local f
		f=$(command brew formulae | fzf --multi --preview 'brew info {}') || return
		[ -n "$f" ] && echo "$f" | xargs command brew install
		return
	fi
	command brew "$@"
}
