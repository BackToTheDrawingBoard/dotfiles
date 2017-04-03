#!/bin/bash

# Control flow variables
ASK_FOR_LINKS="true"

# Paths
DOTFILES_DIR=$(dirname $(readlink -f $0))
__ASK="$DOTFILES_DIR/ask.sh"

echo $DOTFILES_DIR
echo $__ASK
exit 0

if $__ASK "Is $HOME the correct home directory?" Y; then
	DOTFILES_HOME=$HOME
else
	read -p \
"Please give me the full (absolute) path of the home directory that you want me
to use for the dotfiles, or just press enter to quit.
" DOTFILES_HOME

	# Check for an empty string
	if [ -z "$DOTFILES_HOME" ]; then
		exit 0
	fi

	DOTFILES_HOME=$(dirname $DOTFILES_HOME)

	# Check for an existing path
	if ! [ -d "$DOTFILES_HOME" ]; then
		if $__ASK \
"$DOTFILES_HOME does not exist. 
Should I create this directory?" N; then
			mkdir $DOTFILES_HOME
		else
			exit 1
		fi
	fi
fi


if $__ASK \
"Hey, I'm going to run through the basic setup for BackToTheDrawingBoard's 
dotfiles. Do you want me to ask for confirmation before every link that I
create?" Y ; then
	ASK_FOR_LINKS="true"
else
	ASK_FOR_LINKS="false"
fi

if [ "$ASK_FOR_LINKS" == "false" ] || $__ASK \
"Should I make and link a configuration file for i3?" Y; then
	$DOTFILES_DIR/i3/make_config.sh
	mkdir $DOTFILES_HOME/.config/i3
	ln -s $DOTFILES_DIR/i3/config $DOTFILES_HOME/.config/i3/config
fi

if [ "$ASK_FOR_LINKS" == "false" ] || $__ASK \
"Link ~/.Xresources?" Y; then
	ln -s $DOTFILES_DIR/Xresources $DOTFILES_HOME/.Xresources
fi

if [ "$ASK_FOR_LINKS" == "false" ] || $__ASK \
"Link ~/.vimrc?" Y; then
	ln -s $DOTFILES_DIR/vimrc $DOTFILES_HOME/.vimrc
fi

# Unclear if my .xinitrc even works :(
# if [ "$ASK_FOR_LINKS" == "false" ] || $__ASK \
# "Link ~/.vimrc?" Y; then
# 	ln -s $DOTFILES_DIR/xinit/xinitrc $DOTFILES_HOME/.xinitrc
# fi
