alias ls='eza --sort=type --time-style=long-iso --color-scale=age'
alias la='ls -a'
alias ll='ls -l'
alias lla='ll -a'
alias lg='ll --git'
alias lga='lla --git'
alias lt='ll --total-size'
alias lta='lla --total-size'
alias lz='ll -Z'
alias lza='lla -Z'

alias tree='eza --tree'

alias genact='clear && genact'

alias cman='man -M /usr/share/man/zh_CN'

# The following aliases are designed for WSL
if (( ${+WSL_DISTRO_NAME} )) {
    # alias shutdown='/mnt/c/Windows/system32/shutdown.exe'
    alias adb='/mnt/c/Program Files/Android/Sdk/platform-tools/adb.exe'
    alias fastboot='/mnt/c/Program Files/Android/Sdk/platform-tools/fastboot.exe'
    alias wsl='/mnt/c/Windows/system32/wsl.exe'
    alias ipconfig='/mnt/c/Windows/system32/ipconfig.exe'
}

alias java8='/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java'
alias java11='/usr/lib/jvm/java-11-openjdk-amd64/bin/java'
alias java17='/usr/lib/jvm/java-17-openjdk-amd64/bin/java'
alias java21='/usr/lib/jvm/java-21-openjdk-amd64/bin/java'

alias javac8='/usr/lib/jvm/java-8-openjdk-amd64/bin/javac'
alias javac11='/usr/lib/jvm/java-11-openjdk-amd64/bin/javac'
alias javac17='/usr/lib/jvm/java-17-openjdk-amd64/bin/javac'
alias javac21='/usr/lib/jvm/java-21-openjdk-amd64/bin/javac'
