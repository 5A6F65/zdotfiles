plugins=(
    # Make sure fzf-tab is the last plugin to bind "^I"
    # (?) and before plugins which will wrap widgets
    atinit='%external%; zicompinit; zicdreplay' atclone='%external%' Aloxaf/fzf-tab

    atload='%external%' zdharma-continuum/fast-syntax-highlighting
    zdharma-continuum/history-search-multi-word

    # Make sure that zsh-abbr is after fast-syntax-highlighting
    # and before zsh-autosuggestions when set ZSH_AUTOSUGGEST_MANUAL_REBIND
    atinit='%external%' atload='%external%' olets/zsh-abbr
    atload='_abbr_log_available_abbreviation'
        olets/zsh-autosuggestions-abbreviations-strategy

    # Make sure that fast-abbr-highlighting is after zsh-abbr
    5A6F65/fast-abbr-highlighting

    atinit='%external%' atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions
    blockf atpull='zinit creinstall -q $dir' zsh-users/zsh-completions

    nocompile='!' atload='zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
        atclone='dircolors -b > $dir/colors.zsh' atpull='%atclone'
            pick='colors.zsh' trapd00r/LS_COLORS

    atinit='%external%' atload='_zshz_precmd; %external%' agkozak/zsh-z
    atinit='%external%' atload='_flush_ysu_buffer' MichaelAquilina/zsh-you-should-use

    # lukechilds/zsh-nvm
    # agkozak/zhooks

    # blockf zdharma-continuum/zui
    # atload='!__zbrowse_precmd' zdharma-continuum/zbrowse
    # zdharma-continuum/zinit-console
    # zdharma-continuum/zsh-cmd-architect
    # zdharma-continuum/zsh-editing-workbench
)

# ${${(M)=ZINIT[LOAD_OPTS]:#*wait=0a*}:+wait=0b}
zinit ${=ZINIT[LOAD_OPTS]} for ${plugins[@]}

# zstyle ':zce:*' keys 'asdghklqwertyuiopzxcvbnmfj;23456789'
# zinit ${=ZINIT[LOAD_OPTS]} for hchbaw/zce.zsh

# HISTDB_FILE=${ZDOTDIR:-$HOME}/.zhistdb
# zinit ${=ZINIT[LOAD_OPTS]} for larkery/zsh-histdb m42e/zsh-histdb-skim

# ZVM_CURSOR_STYLE_ENABLED=false
# zinit ${=ZINIT[LOAD_OPTS]} for atload='zvm_init' jeffreytse/zsh-vi-mode
