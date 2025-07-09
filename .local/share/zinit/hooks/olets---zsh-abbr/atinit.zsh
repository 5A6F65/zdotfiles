() {
    local config_dir config_file
    local -a config_files

    config_dir=${XDG_CONFIG_HOME:-$HOME/.config}/zsh-abbr
    data_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh-abbr
    data_file=$data_dir/current
    [[ -d $config_dir ]] || return
    [[ -d $data_dir ]] || mkdir -p $data_dir || return
    [[ ! -f $data_file ]] || print -n > $data_file || return

    # if [[ $OSTYPE == linux-android ]] {
    #     case ${${(s:/:)PREFIX}[3]} {
    #         (com.termux) ;;
    #     }
    # } elif [[ -f /etc/os-release ]] {
    #     source /etc/os-release
    #     case $ID {
    #         (ubuntu|debian) ;;
    #         (arch) ;;
    #     }
    # }

    for config_file ($config_dir/commands/*(N)) {
        (( ${+commands[${config_file:t}]} )) || continue
        config_files+=($config_file)
    }
    config_files+=($config_dir/misc)

    for config_file ($config_files) {
        [[ -f $config_file && -r $config_file ]] || continue
        print -r -- "$(<$config_file)" >> $data_file
    }

    ABBR_USER_ABBREVIATIONS_FILE=$data_file
}

ABBR_DEFAULT_BINDINGS=0
ABBR_SET_EXPANSION_CURSOR=1
ABBR_GET_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION_AFTER=1
ABBR_AUTOLOAD=0
