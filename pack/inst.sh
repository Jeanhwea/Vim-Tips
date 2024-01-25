#!/usr/bin/env bash
HERE=`cd $(dirname $0)`
cd $HERE

mkdir -p bundle/start

git clone https://github.com/tpope/vim-pathogen.git   ./bundle/start/pathogen
git clone https://github.com/tpope/vim-commentary.git ./bundle/start/commentary
git clone https://github.com/tpope/vim-dispatch.git   ./bundle/start/dispatch
git clone https://github.com/tpope/vim-fugitive.git   ./bundle/start/fugitive
git clone https://github.com/tpope/vim-repeat.git     ./bundle/start/repeat
git clone https://github.com/tpope/vim-scriptease.git ./bundle/start/scriptease
git clone https://github.com/tpope/vim-sensible.git   ./bundle/start/sensible
git clone https://github.com/tpope/vim-surround.git   ./bundle/start/surround
git clone https://github.com/tpope/vim-unimpaired.git ./bundle/start/unimpaired
git clone https://github.com/tpope/vim-endwise.git    ./bundle/start/endwise
git clone https://github.com/tpope/vim-abolish.git    ./bundle/start/abolish

