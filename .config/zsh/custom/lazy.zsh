sdk() {
    unfunction sdk
    () { [[ -f $1 && -r $1 ]] && source $1; } \
        $HOME/.sdkman/bin/sdkman-init.sh
    sdk $@
}
