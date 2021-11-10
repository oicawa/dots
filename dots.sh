#!/bin/bash

DOTS_DIR=$(cd $(dirname $0);pwd)
echo base directory ... ${DOTS_DIR}

function deploy () {
	echo -n "Input remote host name or remote host IP address >> "
	read REMOTE_HOST
	echo -n "Input user account on the remote host>> "
	read USER_ACCOUNT
	scp -p ${DOTS_DIR} ${USER_ACCOUNT}@${REMOTE_HOST}:~ 
}

function vundle () {
	VUNDLE_DIR=${DOTS_DIR}/../Vundle.vim
	BUNDLE_DIR=${DOTS_DIR}/vim/bundle
	VUNDLE_LNK=${BUNDLE_DIR}/Vundle.vim
	if [ ! -d ${VUNDLE_DIR} ]; then
		echo "Clone Vundle.vim from github.com."
		git clone https://github.com/VundleVim/Vundle.vim.git ${VUNDLE_DIR}
	fi
	mkdir -p ${BUNDLE_DIR}
	if [ ! -L ${VUNDLE_LNK} ]; then
		echo "Create a symbolic link for Vundle.vim."
		ln -s ${VUNDLE_DIR} ${VUNDLE_LNK}
	fi
}

function setup () {
	for item in $( ls ${DOTS_DIR} | grep -v "dots.*" | grep -v "LICENSE" ); do
		if [ ! -L ~/.${item} ]; then
			echo ${item}
			ln -s ${DOTS_DIR}/${item} ~/.${item}
		fi
	done
	vundle
}

function operate () {
	case "$1" in
		"deploy" ) deploy ;;
		"setup"  ) setup ;;
        * )        echo "Illegal menu." ;;
	esac
}

function main () {
	if [ "$1" != "" ]; then
		operate $1	
		exit 0
	fi
	# Input menu
	echo "----- Menu ------------------------------------"
	echo "deploy : Deploy whole dots directory resources."
	echo "setup  : Setup all dots directories."
	echo "-----------------------------------------------"
	echo -n "Input menu string >> "
	read ITEM
	#echo ${ITEM}
	operate ${ITEM}
}

main $1
