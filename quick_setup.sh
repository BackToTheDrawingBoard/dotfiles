#!/bin/bash

$(dirname $(readlink -f $0))/i3/make_config.sh
ln -s $(dirname $(readlink -f $0))/i3 $HOME/.config/i3
ln -s $(dirname $(readlink -f $0))/Xresources $HOME/.Xresources
ln -s $(dirname $(readlink -f $0))/vimrc $HOME/.vimrc
ln -s $(dirname $(readlink -f $0))/xinit/xinitrc $HOME/.xinitrc
