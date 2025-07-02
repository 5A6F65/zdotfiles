() {
    local cmd

    for cmd (git-{branch,checkout,merge,rebase,switch} z) {
        zstyle ":completion:*:$cmd:*" sort false
    }

    for cmd (z cd rm ls eza code) {
        zstyle ":fzf-tab:complete:$cmd:*" query-string input
        zstyle ":fzf-tab:complete:$cmd:*" fzf-preview 'eza --tree --level=2 --color=always $realpath'
        zstyle ":fzf-tab:complete:$cmd:*" popup-pad 30 0
    }

    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' menu no
    zstyle ':completion:*' list-dirs-first true

    zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
    zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
    zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3

    zstyle ":fzf-tab:*" fzf-flags --color=fg:1,fg+:2
    zstyle ':fzf-tab:*' switch-group '<' '>'
    zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
    zstyle ':fzf-tab:*' fzf-bindings 'ctrl-z:toggle+down' 'ctrl-x:up+toggle'

    return 0
}
