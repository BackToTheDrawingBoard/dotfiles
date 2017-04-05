
#!/bin/bash

pushd $(dirname $(readlink -f $0))
$__ASK="./ask.sh"

echo $__ASK
exit 0

if ! [ "$EUID" == "0" ]; then
	echo \
"Please run this script as root. It is responsible for setting up repositories
and running apt-get installations."
	exit 1
fi

if ask "Should I apt-get update and upgrade?" Y; then
	apt-get update
	apt-get upgrade
fi

if ask "Should I confirm with you before I add a respository?" Y; then
	ASK_FOR_ADDING_REPOS="true"
else
	ASK_FOR_ADDING_REPOS="false"
fi

if ask "Should I confirm with you before I install a package?" Y; then
	ASK_FOR_INSTALL="true"
else
	ASK_FOR_INSTALL="false"
fi

APT_LIST_DIR="/etc/apt/sources.list.d"

#
# WebUpd8 Team - JDK 8
#
if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
"Can I add the WebUpd8 Team respository to install JDK 8? " Y; then

	sudo add-apt-repository ppa:webupd8team/java

	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

	if [ "$ASK_FOR_INSTALL" == "false" ] || ask "Can I install JDK8?" Y; then
		apt-get update
		apt-get install oracle-java8-installer
	fi

fi

#
# Graphics Drivers - Proprietary graphics drivers
#
if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
"Can I add the graphics-drivers PPA for access to proprietary graphics drivers?
Please note that I use the Unity proprietary drivers menu to handle installing
these packages." Y; then

	add-apt-repository ppa:graphics-drivers/ppa
fi

#
# Google - All hail the corporate overlords
#
if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
"Can I add Google repositories?" Y; then

	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | \
		apt-key add -

	if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
	"Can I add Google Chrome?" Y; then

		cat lists/google-chrome.list | \
			tee -a $APT_LIST_DIR/google-chrome.list

		if [ "$ASK_FOR_INSTALL" == "false" ] || ask "And should I install Chrome?" Y; then
			apt-get update
			apt-get install google-chrome-stable
		fi
	fi

	if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
	"Can I add Google Web Designer?" Y; then

		cat lists/google-webdesigner.list | \
			tee -a $APT_LIST_DIR/google-webdesigner.list

		if [ "$ASK_FOR_INSTALL" == "false" ] || ask "And should I install Web Designer?" Y; then
			apt-get update
			apt-get install google-webdesigner
		fi
	fi
fi

#
# Spotify - Moosik
#
if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
"Can I add Spotify's repository?" Y; then

	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
		--recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

	cat lists/spotify.list | \
		tee -a $APT_LIST_DIR/spotify.list

	if [ "$ASK_FOR_INSTALL" == "false" ] || ask "And should I install Spotify?" Y; then
		apt-get update
		apt-get install spotify-client
	fi
fi

#
# Resilio Sync - Personal mobile backups
#
if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
"Can I add Resilio Sync's repository?" Y; then

	cat lists/resilio-sync.list | \
		tee $APT_LIST_DIR/resilio-sync.list

	wget -qO - https://linux-packages.resilio.com/resilio-sync/key.asc | \
		apt-key add -

	if [ "$ASK_FOR_INSTALL" == "false" ] || ask "And should I install Resilio Sync?" Y; then
		apt-get update
		apt-get install resilio-sync
	fi
fi

#
# Steam
#
if [ "$ASK_FOR_ADDING_REPOS" == "false" ] || ask \
"Can I add Steam's repository?" Y; then

	cat lists/steam.list | \
		tee $APT_LIST_DIR/steam.list

	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7


	if [ "$ASK_FOR_INSTALL" == "false" ] || ask "And should I install Resilio Sync?" Y; then
		apt-get update
		apt-get install steam-launcher
	fi
fi

# Ubuntu's normal packages

if [ "$ASK_FOR_INSTALL" == "false" ]; then
	apt-get install \
		vim \
		rofi \
		blender \
		gimp \
		i3 \
		gparted \
		inkscape \
		libncurses5-dev \
		libncursesw5-dev \
		r-base \
		rstudio \
		steam-launcher \
		sublime-text \
		valgrind \
		virtualbox-5.1
else
	ask "Install vim?" Y 				&& apt-get install vim
	ask "Install rofi?" Y 				&& apt-get install rofi
	ask "Install blender?" Y 			&& apt-get install blender
	ask "Install gimp?" Y 				&& apt-get install gimp
	ask "Install i3?" Y 				&& apt-get install i3
	ask "Install gparted?" Y 			&& apt-get install gparted
	ask "Install inkscape?" Y 			&& apt-get install inkscape
	ask "Install libncurses5-dev?" Y 	&& apt-get install libncurses5-dev
	ask "Install libncursesw5-dev?" Y 	&& apt-get install libncursesw5-dev
	ask "Install r-base?" Y 			&& apt-get install r-base
	ask "Install rstudio?" Y 			&& apt-get install rstudio
	ask "Install sublime-text?" Y 		&& apt-get install sublime-text
	ask "Install valgrind?" Y 			&& apt-get install valgrind
	ask "Install virtualbox-5.1?" Y 	&& apt-get install virtualbox-5.1
fi















