#!/bin/bash

if [ -z $1 ]; then 
	echo "Usage: build.sh <version number>";
	exit 1;
fi

cd workspace
tar -czvf ../builds/ilx-zlib-${1}.tgz ./*

