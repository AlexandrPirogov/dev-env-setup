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
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
call plug#end()

filetype plugin indent on

set autowrite

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
au filetype go inoremap <buffer> . .<C-x><C-o>
:set completeopt=longest,menuone
EOF

# Open Vim and install plugins
vim +'PlugInstall --sync' +qa

echo "Vim and plugins setup complete!"
