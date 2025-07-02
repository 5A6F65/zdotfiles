.zinit-fix-omz-plugin() {
    [[ -d $dir/._zinit ]] || return 1

    local pluginid
    local file

    for pluginid (${dirname#OMZ::plugins/} ${dirname#OMZP::}) {
        [[ $pluginid != $dirname ]] && break
    }
    (( $? )) && return 1

    print "Fixing $dirname..."
    rm -rf $dir/ohmyzsh
    git clone --quiet --no-checkout --depth=1 --filter=tree:0 \
        https://github.com/ohmyzsh/ohmyzsh "$dir/ohmyzsh"
    git -C "$dir/ohmyzsh" sparse-checkout set --no-cone "plugins/$pluginid"
    git -C "$dir/ohmyzsh" checkout --quiet 2>/dev/null # --quiet doesn't seem to work here?
    for file ($dir/ohmyzsh/plugins/$pluginid/*~(.gitignore|*.plugin.zsh)(D)) {
        [[ ${file:t} != "README.md" ]] && print "Copying ${file:t}..."
        cp -R $file $dir/${file:t}
    }
    rm -rf $dir/ohmyzsh
    return 0
}

zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

zinit ${=ZINIT[LOAD_OPTS]} for \
    OMZL::{completion,key-bindings}.zsh \
    as='completion' OMZP::rust/_rustc \
    OMZP::{sudo,ssh-agent}
zinit ${=ZINIT[LOAD_OPTS]/nocd/} \
    atclone='.zinit-fix-omz-plugin' atpull='%atclone' for \
        OMZP::{extract,colored-man-pages}
