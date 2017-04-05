#!/bin/bash

# This function is taken from Airblader's setup script, which, in turn, cites
# http://djm.me/ask as being the original source.

while true; do

	if [ "${2:-}" = "Y" ]; then
		prompt="Y/n"
		default=Y
	elif [ "${2:-}" = "N" ]; then
		prompt="y/N"
		default=N
	else
		prompt="y/n"
		default=
	fi

	# Ask the question
	read -p "$1 [$prompt] " REPLY

	# Default?
	if [ -z "$REPLY" ]; then
		 REPLY=$default
	fi

	# Check if the reply is valid
	case "$REPLY" in
		Y*|y*) exit 0 ;;
		N*|n*) exit 1 ;;
	esac

done