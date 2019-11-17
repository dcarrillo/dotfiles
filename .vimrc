" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

syntax on
set tabstop=4
set shiftwidth=4
set expandtab

let mapleader=","
