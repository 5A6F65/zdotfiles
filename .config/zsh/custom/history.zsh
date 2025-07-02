export HISTFILE=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history
export HISTSIZE=50000
export SAVEHIST=10000
export HISTORY_IGNORE='(l(s|l|a|la)|history -(c|-clear|d|-delete)(| *))'

setopt EXTENDED_HISTORY
# setopt HIST_EXPIRE_DUPS_FIRST
# setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
# setopt HIST_NO_FUNCTIONS
# setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
# setopt INC_APPEND_HISTORY_TIME

function history() {
    zmodload zsh/zutil || return

    # If -c/--clear provided, clear the history file.
    local clear
    zparseopts -D {c,-clear}=clear
    if (( $#clear )) {
        (( $# )) && print -P "%F{003}Other parameters are meaningless when '$clear' exists.%f"
        if (( ! $#HISTFILE )) {
            print -P "%F{005}HISTFILE not set.%f"
            return 1
        }
        local intent
        read "intent?Clear '${HISTFILE/$HOME/~}'? [y/N] "
        if [[ $intent =~ '^[Yy]$' ]] {
            print -n > $HISTFILE
            fc -p $HISTFILE
            print -P "%F{002}Cleared '${HISTFILE/$HOME/~}'.%f"
            return 0
        }
        [[ $intent =~ '^[Nn]?$' ]] || print -P "%F{003}What does '$intent' mean?%f"
        return 0
    }

    # If -d/--delete provided, delete the specified history (default is last line).
    local delete
    zparseopts -D {d,-delete}=delete
    if (( $#delete )) {
        if (( ! $#HISTFILE )) {
            print -P "%F{005}HISTFILE not set.%f"
            return 1
        }
        local target intent HISTORY_IGNORE=$HISTORY_IGNORE
        for target (${@:--1}) {
            [[ $target =~ '^\-?[0-9]+' ]] && target=${(b)$(fc -ln $target $target)}
            read "intent?Delete '$target' from history? [Y/n] "
            [[ $intent =~ '^[Nn]$' ]] && continue
            [[ $intent =~ '^[Yy]?$' ]] || print -P "%F{003}What does '$intent' mean?%f"
            HISTORY_IGNORE+="|$target"
        }
        HISTORY_IGNORE="($HISTORY_IGNORE)"
        cp -f $HISTFILE $HISTFILE.bk
        fc -IA
        if (( $+commands[colordiff] )) {
            colordiff -u $HISTFILE.bk $HISTFILE | ${PAGER:-most}
        } else {
            diff -u $HISTFILE.bk $HISTFILE | ${PAGER:-most}
        }
        read "intent?Roll back HISTFILE? [Y/n] "
        if [[ $intent =~ '^[Nn]$' ]] {
            print -P "%F{002}Deleted $(($(wc -l < $HISTFILE.bk)-$(wc -l < $HISTFILE))) lines.%f"
            rm -f $HISTFILE.bk
            fc -p $HISTFILE
            return 0
        }
        [[ $intent =~ '^[Yy]?$' ]] || print -P "%F{003}What does '$intent' mean?%f"
        mv -f $HISTFILE.bk $HISTFILE
        print -P "%F{003}Rolled back HISTFILE.%f"
        return 0
    }

    # If -s/--stats provided, stats the 20 most used commands (like 'zsh_stats').
    # Inaccurate, for reference only.
    local stats
    zparseopts -D {s,-stats}=stats
    if (( $#stats )) {
        (( $# )) && print -P "%F{003}Other parameters are meaningless when '$stats' exists.%f"
        fc -l 1 \
            | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
            | grep -v "./" | sort -nr | head -n 20 | column -c3 -s " " -t | nl
        return 0
    }

    # Or else it's like an alias for 'history -t <timefmt>'.
    builtin history -t '%Y-%m-%d %T' ${@}
}

