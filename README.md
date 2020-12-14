# NVIM config files

This repository contains my confiuration files for Neovim! This is mainly set
up for C++ and Python. For some introduction to keybindings etc. see vimwiki/

## Installation

* Install Neovim (>= 0.5.0)
* Install vim-plug (https://github.com/junegunn/vim-plug)
* Clone repository and make sure that Neovim is reading the configs
* Source config and run :PlugInstall

## Autocompletion

I use CoC for autocompletion. For C++ I use clangd (https://github.com/clangd/coc-clangd)
and for Python I use coc-python (https://github.com/neoclide/coc-python)
Running :CocInstall coc-python :CocInstall coc-clangd should make it work out of the box.
clangd will be installed automatically.


## TODOS

* Move over to Nvims native LSP for autocompletion
