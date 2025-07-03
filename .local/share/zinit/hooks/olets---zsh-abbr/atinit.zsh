() {
    local dir file
    local -a files

    dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh-abbr
    [[ -d $dir ]] || return

    if [[ $PREFIX == /data/data/com.termux/files/usr ]] {
        files+=(commands/pkg)
    } elif [[ -f /etc/os-release ]] {
        source /etc/os-release
        case $ID {
            (ubuntu|debian) files+=(commands/{apt,snap}) ;;
            (arch) files+=(commands/pacman) ;;
        }
    }
    files+=(commands/{git,gitflow,yadm} general)

    rm -rf $dir/current
    for file ($files) {
        [[ -f $dir/$file && -r $dir/$file ]] || continue
        print -r -- "$(<$dir/$file)" >> $dir/current
    }

    ABBR_USER_ABBREVIATIONS_FILE=$dir/current
}

ABBR_DEFAULT_BINDINGS=0
ABBR_SET_EXPANSION_CURSOR=1
ABBR_GET_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION_AFTER=1
ABBR_AUTOLOAD=0
