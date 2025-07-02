export LESS='-R --mouse'
# export LESSOPEN="| /usr/bin/lesspipe %s"
# export LESSCLOSE="/usr/bin/lesspipe %s %s"

export NODE_OPTIONS='--disable-warning=ExperimentalWarning'

path=(/usr/local/texlive/2024/bin/x86_64-linux $path)
manpath=(/usr/local/texlive/2024/texmf-dist/doc/man $manpath)
infopath=(/usr/local/texlive/2024/texmf-dist/doc/info $infopath)

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
path=($JAVA_HOME/bin $path)

# export ANDROID_HOME=$HOME/android/sdk
# path=($ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools $path)

# export GOPATH=$HOME/go
# path=($GOPATH/bin $path)

path=($HOME/.{ghcup,cabal,cargo}/bin $path)

path=(/snap/bin $path)

path=($HOME/.local/bin $path)
