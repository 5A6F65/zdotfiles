# Differences from Pure:
#   - `@c4d3ec2c` instead of something like `v1.4.0~11` when in detached HEAD state.
#   - No automatic `git fetch` (the same as in Pure with `PURE_GIT_PULL=0`).
# Apart from the differences listed above, the replication of Pure prompt is exact.
# This includes even the questionable parts.
# For example, just like in Pure, there is no indication of Git status being stale;
# prompt symbol is the same in command, visual and overwrite vi modes;
# when prompt doesn't fit on one line, it wraps around with no attempt to shorten it.

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  
  # Unset all configuration options.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  
  # Zsh >= 5.1 is required.
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return
  
  # Prompt colors.
  local black='0'
  local red='1'
  local green='2'
  local yellow='3'
  local blue='4'
  local magenta='5'
  local cyan='6'
  local white='7'
  local grey='242'
  
  # Left prompt segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    newline                   # add an empty line
    context                   # user@hostname
    dir                       # current directory
    vcs                       # git status
    command_execution_time    # previous command duration
    time                      # current time
    # =========================[ Line #2 ]=========================
    newline                   # new line
    prompt_char               # prompt symbol
  )
  
  # Don't show any right prompt segment.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=
  
  # Basic style options that define the overall prompt look.
  typeset -g POWERLEVEL9K_BACKGROUND=                      # transparent background
  typeset -g POWERLEVEL9K_LEFT_{LEFT,RIGHT}_WHITESPACE=    # no surrounding whitespace
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '    # separate segments with a space
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=          # no end-of-line symbol
  
  ### context: user@hostname ###
  # It's better to set context color in CONTEXT_TEMPLATE.
  # This is just to change SUBSEGMENT_SEPARATOR color.
  typeset -g POWERLEVEL9K_CONTEXT_{FOREGROUND,ROOT_FOREGROUND}=$grey
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=$white
  # Context format.
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%F{$grey}%n@%m%f"
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%F{$white}%n%F{$grey}@%m%f"
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE="%F{$grey}%n%F{$white}@%m%f"
  # Don't show context unless running with privileges or in SSH.
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=
  # Custom prefix.
  # typeset -g POWERLEVEL9K_CONTEXT_PREFIX="%fwith "
  
  ### dir: current directory ###
  # Directory color.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$cyan
  # Custom prefix.
  # typeset -g POWERLEVEL9K_DIR_PREFIX='%fin '
  
  ### vcs: git status ###
  # Grey Git prompt. This makes stale prompts indistinguishable from up-to-date ones.
  typeset -g POWERLEVEL9K_VCS_FOREGROUND=$grey
  # Disable async loading indicator to make directories that aren't Git repositories
  # indistinguishable from large Git repositories without known state.
  typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=
  # Don't wait for Git status even for a millisecond, so that prompt always updates
  # asynchronously when Git state changes.
  typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0
  # Cyan ahead/behind arrows.
  typeset -g POWERLEVEL9K_VCS_{INCOMING,OUTGOING}_CHANGESFORMAT_FOREGROUND=$cyan
  # Don't show remote branch, current tag or stashes.
  typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)
  # Don't show the branch icon.
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
  # When in detached HEAD state, show @commit where branch normally goes.
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
  # Don't show staged, unstaged, untracked indicators.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED}_ICON=
  # Show '*' when there are staged, unstaged or untracked files.
  typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='*'
  # Show '⇣' if local branch is behind remote.
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=':⇣'
  # Show '⇡' if local branch is ahead of remote.
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=':⇡'
  # Don't show the number of commits next to the ahead/behind arrows.
  typeset -g POWERLEVEL9K_VCS_{COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=1
  # Remove space between '⇣' and '⇡' and all trailing spaces.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${${${P9K_CONTENT/⇣* :⇡/⇣⇡}// }//:/ }'
  # Custom prefix.
  # typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '
  
  ### command_execution_time: previous command duration ###
  # Duration color.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$grey
  # Duration format.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  # Show duration if takes at least this many seconds.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
  # Show this many fractional digits.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2
  # Custom prefix.
  # typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%ftook '
  
  ### time: current time ###
  # Time color.
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=$black
  # Time format. See `man 3 strftime`.
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  # Time will update when hit enter.
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true
  # Custom prefix.
  # typeset -g POWERLEVEL9K_TIME_PREFIX='%fat '
  
  ### prompt_char: prompt symbol ###
  # Prompt symbol color.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$white
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$red
  # Prompt symbol format
  # default mode / command vi mode / visual vi mode / overwrite vi mode
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  
  # Transient prompt mode.
  # off / always / same-dir
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  
  # Instant prompt mode.
  # off / quiet / verbose
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  
  # Hot reload can slow down prompt by 1ms to 2ms.
  # So it's better to keep it turned off unless you really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
  
  # If p10k is already loaded, reload configuration.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}.tmp

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
