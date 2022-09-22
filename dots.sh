#!/bin/bash

DOTS_DIR=$(cd $(dirname $0);pwd)
echo base directory ... ${DOTS_DIR}

function deploy () {
	echo -n "Input remote host name or remote host IP address >> "
	read REMOTE_HOST
	echo -n "Input user account on the remote host>> "
	read USER_ACCOUNT
	for ITEM in $( ls ${DOTS_DIR} ); do
		echo ${ITEM}
		scp -pr ${DOTS_DIR}/${ITEM} ${USER_ACCOUNT}@${REMOTE_HOST}:~/${DOTS_DIR} 
	done
}

function setup () {
	for item in $( ls ${DOTS_DIR} | grep -v "dots.*" | grep -v "LICENSE" ); do
		echo ${item}
		ln -s ${DOTS_DIR}/${item} ~/.${item}
	done
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
