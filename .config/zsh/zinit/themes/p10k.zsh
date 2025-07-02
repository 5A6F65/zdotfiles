p10k_config_file=${ZDOTDIR:-$HOME}/themes/p10k.zsh
[[ -f $p10k_config_file && -r $p10k_config_file ]] && source $p10k_config_file
zinit ${=ZINIT[LOAD_OPTS]/wait* lucid/} for romkatv/powerlevel10k
