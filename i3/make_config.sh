#!/bin/bash

# This will pull together all of the configuration files for i3 into
# one main config so that it can be loaded

pushd $(dirname $(readlink -f $0))

cat variables.txt \
	base.txt \
	control.txt \
	launch.txt \
	pretty.txt \
	startup.txt \
> config

popd
