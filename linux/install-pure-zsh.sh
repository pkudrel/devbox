#!/bin/sh

mkdir -p ~/.local/misc/pure
wget -O ~/.local/misc/pure/pure.zsh https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
wget -O ~/.local/misc/pure/async.zsh https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh

mkdir -p ~/zfunctions
ln -s ~/.local/misc/pure/pure.zsh ~/zfunctions/prompt_pure_setup
ln -s ~/.local/misc/pure/async.zsh ~/zfunctions/async

