#!/bin/bash
# version 1.0

function bacula_ver {
	read -ep "Select bacula version: 1) Bacula11, 2) Bacula9.6 (Type 1 or 2): " -N 1 bversion
	checker_ver
}

function checker_ver {
	if [ $bversion == 1 ];then
		ver="11"
		get_sources
		build_image
		rm -rf bacula_src
	elif [ $bversion == 2 ];then
		ver="9.6"
		build_image
	else
		echo -e "\nYou should type '1' or '2'"
		bacula_ver
	fi
}

function get_sources {
		mkdir bacula_src
		curl -s $(curl -s https://www.bacula.org/source-download-center/ | grep download-link | head -1 | sed -e 's/^.*href="//' -e 's/" rel.*$//') -o bacula_src/bacula_src.tgz
		cd bacula_src && tar -zxvf bacula_src.tgz 
		mv $(find -maxdepth 1 -type d -name "bacula*") bacula_src
		cd ..
}

function build_image {
	echo -e "\nBuilding image"
	docker build -t bacula-client:$ver -f $ver/Dockerfile --force-rm .
}

if [ "$#" == "0" ]; then
	bacula_ver
elif [ "$#" != "1" ]; then
	echo "Illegal number of parameters"
	exit 2
elif [ "$#" == "1" ]; then
	if [ $1 == "11" ]; then
		ver="11"
		get_sources
		build_image
		rm -rf bacula_src
	elif [ $1 == "9.6" ]; then
		ver="9.6"
		build_image
	fi
else
	echo "Unknown error"
	exit 2
fi

