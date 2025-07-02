() {
    (( ${#ZINIT[HOME_DIR]} )) || return 1
    : ${ZINIT[HOOKS_DIR]:=$ZINIT[HOME_DIR]/hooks}

    za-external-hook-handler() {
        (( ${#ZINIT[HOOKS_DIR]} )) || return
        [[ $1 != plugin ]] && return

        local -r dir=${5:t}
        local -r hook=${6#!}

        [[ ${hook[1,2]} == 'at' ]] || return
        (( ! ${${ICE[$hook]}[(I)%external%]} )) && return
        local -r file="${ZINIT[HOOKS_DIR]}/$dir/$hook.zsh"
        [[ -f $file && -r $file ]] || return
        ICE[$hook]=${ICE[$hook]//'%external%'/"source $file"}
        return 0
    }

    za-external-hook-help-handler() { :; }

    local hook
    for hook (at{init,load,clone,pull}) {
        @zinit-register-annex "zinit-annex-external-hook" \
            hook:!$hook-100 \
            za-external-hook-handler \
            za-external-hook-help-handler
    }
    return 0
}
