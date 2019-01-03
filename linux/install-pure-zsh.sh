#!/bin/sh

mkdir -p ~/.local/misc/pure
wget -O ~/.local/misc/pure/pure.zsh https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
wget -O ~/.local/misc/pure/async.zsh https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh

mkdir -p ~/.oh-my-zsh/functions
ln -s ~/.local/misc/pure/pure.zsh ~/.oh-my-zsh/functions/pure.zsh
ln -s ~/.local/misc/pure/async.zsh ~/.oh-my-zsh/functions/async.zsh
