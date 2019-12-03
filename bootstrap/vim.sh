curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
ln -s nvim.vim ~/.config/nvim/init.vim
ln -s .vimrc ~/.vimrc
