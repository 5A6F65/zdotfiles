() {
    (( ${+functions[zshz]} )) || return

    (( ${+_comps} )) && _comps[zshz]=_files

    (( ${+aliases[z]} )) && unalias z
    function z() {
        if (( $# == 0 )) {
            zshz $HOME
            return 0
        }
        case $1 {
            ("-") (( ${#OLDPWD} )) && zshz $OLDPWD;;
            ("-l"|"--list") zshz;;
            (*) zshz $@;;
        }
        return 0
    }
    return 0
}
