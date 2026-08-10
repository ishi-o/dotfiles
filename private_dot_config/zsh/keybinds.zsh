# ZLE, fzf and Kitty keybindings.

bindkey -M viins 'jj' vi-cmd-mode
bindkey '' autosuggest-accept
for keymap in viins vicmd emacs; do
    bindkey -M "$keymap" '^O' clear-screen
done

# Kitty uses one user variable with two values:
# 1 = zsh completion, 2 = an fzf selector.
_kitty_selector_mode() {
    local mode=$1 value
    [[ -n ${KITTY_WINDOW_ID:-} ]] || return 0
    case $mode in
        completion) value=MQ== ;;
        fzf)        value=Mg== ;;
        *)
            [[ ${_KITTY_SELECTOR_MODE:-} == none ]] && return 0
            typeset -g _KITTY_SELECTOR_MODE=none
            printf '\033]1337;SetUserVar=ZSH_SELECTOR_MODE\007'
            return 0
            ;;
    esac
    [[ ${_KITTY_SELECTOR_MODE:-} == $mode ]] && return 0
    typeset -g _KITTY_SELECTOR_MODE=$mode
    printf '\033]1337;SetUserVar=ZSH_SELECTOR_MODE=%s\007' "$value"
}

_kitty_keymap_select() {
    if [[ $KEYMAP == menuselect ]]; then
        _kitty_selector_mode completion
    elif [[ ${_KITTY_SELECTOR_MODE:-} != fzf ]]; then
        _kitty_selector_mode
    fi
}

_kitty_line_init() { _kitty_selector_mode }
_kitty_line_finish() { _kitty_selector_mode }

autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-keymap-select _kitty_keymap_select
add-zle-hook-widget zle-line-init _kitty_line_init
add-zle-hook-widget zle-line-finish _kitty_line_finish

zmodload -i zsh/complist
bindkey -M menuselect '^[j' down-line-or-history
bindkey -M menuselect '^[k' up-line-or-history

zstyle ':fzf-tab:*' fzf-bindings 'alt-j:down' 'alt-k:up'
export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:+$FZF_CTRL_R_OPTS }--bind=alt-j:down,alt-k:up"
export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS:+$FZF_CTRL_T_OPTS }--bind=alt-j:down,alt-k:up"

typeset -gA _KITTY_SELECTOR_WIDGET_MODE
_kitty_selector_widget() {
    local widget=$WIDGET original=_kitty_original_$WIDGET
    local ret=0
    _kitty_selector_mode "${_KITTY_SELECTOR_WIDGET_MODE[$widget]}"
    { zle "$original" || ret=$? } always { _kitty_selector_mode }
    return $ret
}

_kitty_wrap_selector_widget() {
    local widget=$1 mode=$2 original=_kitty_original_$1
    (( $+widgets[$widget] && ! $+widgets[$original] )) || return 0
    zle -A "$widget" "$original"
    _KITTY_SELECTOR_WIDGET_MODE[$widget]=$mode
    zle -N "$widget" _kitty_selector_widget
}

_kitty_wrap_selector_widget fzf-tab-complete completion
_kitty_wrap_selector_widget fzf-history-widget fzf
_kitty_wrap_selector_widget fzf-file-widget fzf

unset -f _kitty_wrap_selector_widget
