# ZLE and fzf keybindings.

bindkey -M viins 'jj' vi-cmd-mode
bindkey '' autosuggest-accept
for keymap in viins vicmd emacs; do
    bindkey -M "$keymap" '^O' clear-screen
done

zmodload -i zsh/complist
bindkey -M menuselect '^[j' down-line-or-history
bindkey -M menuselect '^[k' up-line-or-history

zstyle ':fzf-tab:*' fzf-bindings 'alt-j:down' 'alt-k:up' 'ctrl-u:half-page-up' 'ctrl-d:half-page-down'
export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:+$FZF_CTRL_R_OPTS }--bind=alt-j:down,alt-k:up,ctrl-u:half-page-up,ctrl-d:half-page-down"
export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS:+$FZF_CTRL_T_OPTS }--bind=alt-j:down,alt-k:up,ctrl-u:half-page-up,ctrl-d:half-page-down"
