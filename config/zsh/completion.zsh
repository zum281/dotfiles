###################
### COMPLETIONS ###
###################

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q
_comp_options+=(globdots) # include hidden files

##########################
### Completion styling ###
##########################

# case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# enable colors for completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
