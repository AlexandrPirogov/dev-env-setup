#!/bin/bash

# Clear previous setups
rm -rf ~/.vim ~/.vimrc

# Update package lists
sudo apt update

# Install Vim
sudo apt install vim -y

# Download Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create necessary directories for Vim plugins
mkdir -p ~/.vim/plugged

# Create a new Vim configuration file and set it up with Vim-Plug
cat << EOF > ~/.vimrc
" Vim-Plug configuration
call plug#begin('~/.vim/plugged')

" Specify plugins here
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go'

call plug#end()

" Necessary settings
filetype plugin indent on
syntax enable
EOF

# Open Vim and install plugins
vim +'PlugInstall --sync' +qa

echo "Vim and plugins setup complete!"
