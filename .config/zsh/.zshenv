export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export LESS='-R --mouse'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_mb=$'\e[1;31mm'   # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'    # begin bold
export LESS_TERMCAP_us=$'\e[1;332m'   # begin underline
export LESS_TERMCAP_so=$'\e[1;44;33m' # begin standout-mode - info box
export LESS_TERMCAP_me=$'\e[0m'       # end mode
export LESS_TERMCAP_ue=$'\e[0m'       # end underline
export LESS_TERMCAP_se=$'\e[0m'       # end standout-mode

export NODE_OPTIONS='--disable-warning=ExperimentalWarning'

export DELTA_FEATURES="diff-so-fancy"

path=(/usr/local/texlive/2024/bin/x86_64-linux $path)
manpath=(/usr/local/texlive/2024/texmf-dist/doc/man $manpath)
infopath=(/usr/local/texlive/2024/texmf-dist/doc/info $infopath)

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
path=($JAVA_HOME/bin $path)

export ANDROID_HOME=$HOME/android/sdk
path=($ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools $path)

export GOPATH=$HOME/go
path=($GOPATH/bin $path)

path=($HOME/.{ghcup,cabal,cargo}/bin $path)

path=(/snap/bin $path)

path=($HOME/.local/bin $path)
