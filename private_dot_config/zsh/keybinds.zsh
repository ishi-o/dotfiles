# ZLE and fzf keybindings.

bindkey -M viins 'jj' vi-cmd-mode
bindkey '' autosuggest-accept
for keymap in viins vicmd emacs; do
	bindkey -M "$keymap" '^O' clear-screen
done

zmodload -i zsh/complist
bindkey -M menuselect '^J' down-line-or-history
bindkey -M menuselect '^K' up-line-or-history

zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:down' 'ctrl-k:up' 'ctrl-u:half-page-up' 'ctrl-d:half-page-down'
export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:+$FZF_CTRL_R_OPTS }--bind=ctrl-j:down,ctrl-k:up,ctrl-u:half-page-up,ctrl-d:half-page-down"
export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS:+$FZF_CTRL_T_OPTS }--bind=ctrl-j:down,ctrl-k:up,ctrl-u:half-page-up,ctrl-d:half-page-down"

if ((${+widgets[fzf-tab-complete]})); then
	bindkey -M emacs '^I' fzf-tab-complete
	bindkey -M viins '^I' fzf-tab-complete
fi
