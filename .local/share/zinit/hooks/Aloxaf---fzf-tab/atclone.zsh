() {
    print "Building fzf-tab module..."
    if [[ ! -f $dir/fzf-tab.plugin.zsh ]] {
        print "Failed to find 'fzf-tab.plugin.zsh'"
        return 1
    }
    source $dir/fzf-tab.plugin.zsh
    if (( ! ${+functions[build-fzf-tab-module]} )) {
        print "Failed to find 'build-fzf-tab-module'"
        return 1
    }
    build-fzf-tab-module
    return 0
}
