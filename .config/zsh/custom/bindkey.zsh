function _help_command_line() {
    local -a cmds
    local fullback=$1
    cmds=(${${BUFFER:-$(fc -ln -1)}})
    BUFFER="[$cmds]"
    return 0
    if [[ ${cmds[1]} == "sudo" ]] {
        fullback="sudo"
        cmds[1]=()
    }
    if [[ ${cmds[1]} == $1 ]] {
        fullback=$1
        cmds[1]=()
        if (( ${#cmds} )) {
            BUFFER="$cmds"
            CURSOR=$#BUFFER
            zle redisplay
            return 0
        }
    } elif [[ ${cmds[1]} == ("man"|"tldr") ]] {
        fullback=${cmds[1]}
        cmds[1]=()
    }
    BUFFER="[$cmds]"
    return 0
    cmds=($cmds[1,2])
    [[ ${cmds[2][1]} == ('-'|'$'|'|'|'&'|'('|'['|'{') ]] && cmds[2]=()
    [[ ${cmds[1][1]} == ('-'|'$'|'|'|'&'|'('|'['|'{') ]] && cmds[1]=()
    BUFFER="$1 ${cmds:-$fullback}"
    CURSOR=${#BUFFER}
    zle redisplay
    return 0
}

local -A help_commands=(
    man    '\em'
    tldr   '\et'
    # which  '\ew'
)

for help_command (${(k)help_commands}) {
    ${help_command}-command-line() { _help_command_line tldr; }
    zle -N ${help_command}-command-line
    bindkey "${help_commands[$help_command]}" ${help_command}-command-line
}
