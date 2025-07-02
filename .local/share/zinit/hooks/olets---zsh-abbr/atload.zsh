() {
    abbr-expand-and-redisplay() {
        abbr-expand-and-insert
        zle redisplay
    }
    zle -N abbr-expand-and-redisplay
    bindkey " " abbr-expand-and-redisplay
    # bindkey " " abbr-expand-and-insert
    bindkey "^ " magic-space
    bindkey -M isearch "^ " abbr-expand-and-insert
    bindkey -M isearch " " magic-space
    return 0
}
