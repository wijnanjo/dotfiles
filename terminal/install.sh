SCRIPT_DIR=$(dirname $0)
DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
[ -d ${DIR}/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions.git ${DIR}/plugins/zsh-autosuggestions
[ -d ${DIR}/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${DIR}/plugins/zsh-syntax-highlighting
[ -d ${DIR}/themes/powerlevel10k ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${DIR}/themes/powerlevel10k
[ -d ${DIR}/plugins/streamplatformenv ] || mkdir ${DIR}/plugins/streamplatformenv && cp $SCRIPT_DIR/streamplatformenv.plugin.zsh ${DIR}/plugins/streamplatformenv