typeset -gAH ZINIT
ZINIT[HOME_DIR]=${XDG_DATA_HOME:-${HOME}/.local/share}/zinit
ZINIT[BIN_DIR]=${ZINIT[HOME_DIR]}/zinit.git
ZINIT[ZCOMPDUMP_PATH]=${ZSH_COMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/.zcompdump}
ZINIT[NO_ALIASES]=1
ZINIT[CLONE_DEPTH]=1

if (( ${+functions[_p9k_instant_prompt_precmd_first]} )) || [[ $ZSH_EXECUTION_STRING == exit ]] {
    # When the user enables Instant Prompt or simply executes exit
    # Zinit will load as fast as possible
    ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1
    ZINIT[COMPINIT_OPTS]='-C'
    ZINIT[LOAD_OPTS]="depth=${ZINIT[CLONE_DEPTH]} wait lucid light-mode nocd"
} else {
    # Otherwise, it is assumed that the user is debugging
    # Slow down loading to prevent unexpected behavior
    ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=0
    ZINIT[COMPINIT_OPTS]=''
    ZINIT[LOAD_OPTS]="depth=${ZINIT[CLONE_DEPTH]}"
}

if [[ ! -d ${ZINIT[BIN_DIR]} ]] {
    print -P "%F{004}Installing ZINIT…%f"
    mkdir -p ${ZINIT[BIN_DIR]%/*}
    chmod g-rwX ${ZINIT[BIN_DIR]%/*}
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ${ZINIT[BIN_DIR]}
}

source ${ZINIT[BIN_DIR]}/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zicompinit() {
    setopt extendedglob
    autoload -Uz compinit
    local -a compinit_opts=(${(Q@)${(z@)ZINIT[COMPINIT_OPTS]}})
    local compinit_dump=${ZINIT[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
    local index=${compinit_opts[(I)-C]}
    (( $index )) && [[ ! -f $compinit_dump || -n $compinit_dump(#qN.mh+24) ]] && compinit_opts[$index]=''
    compinit -d $compinit_dump $compinit_opts
}

source ${ZDOTDIR:-$HOME}/zinit/themes/p10k.zsh
source ${ZDOTDIR:-$HOME}/zinit/frameworks/omz.zsh
source ${ZDOTDIR:-$HOME}/zinit/plugins/preinit.zsh
source ${ZDOTDIR:-$HOME}/zinit/plugins/init.zsh
