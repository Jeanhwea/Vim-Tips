#!/usr/bin/env bash

mkdir -p bundle/start

git clone https://github.com/tpope/vim-pathogen.git   ./bundle/start/pathogen
git clone https://github.com/tpope/vim-commentary.git ./bundle/start/commentary
git clone https://github.com/tpope/vim-fugitive.git   ./bundle/start/fugitive
git clone https://github.com/tpope/vim-dispatch.git   ./bundle/start/dispatch
git clone https://github.com/tpope/vim-sensible.git   ./bundle/start/sensible
git clone https://github.com/tpope/vim-scriptease.git ./bundle/start/scriptease
git clone https://github.com/tpope/vim-repeat.git     ./bundle/start/repeat
git clone https://github.com/tpope/vim-unimpaired.git ./bundle/start/unimpaired

