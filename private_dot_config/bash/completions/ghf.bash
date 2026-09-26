_ghf() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    if [ "$COMP_CWORD" -eq 1 ]; then
        COMPREPLY=($(compgen -W "n notif notifications r repo repos repositories i issue issues p pr prs pulls a action actions menu help --help -h" -- "$cur"))
    fi
}
complete -F _ghf ghf
