#!/usr/bin/env bash

mkdir -p bundle/start
cd bundle/start

git clone https://github.com/tpope/vim-pathogen.git   pathogen
git clone https://github.com/tpope/vim-commentary.git commentary
git clone https://github.com/tpope/vim-fugitive.git   fugitive
