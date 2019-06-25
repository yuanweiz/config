sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ -e "$HOME/.vimrc" ]
then
    mv "$HOME/.vimrc" "$HOME/.vimrc.old"
fi
ln -s ./.vimrc ~/.vimrc 

if [ -e "$HOME/.tmux.conf" ]
then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.old"
fi
ln -s ./tmux/.tmux.conf ~/.tmux.conf

if [ -e "$HOME/.zshrc" ]
then
    mv "$HOME/.zshrc" "$HOME/.zshrc.old"
fi
ln -s ./.zshrc ~/.zshrc
