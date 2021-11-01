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
	if [ "$1" -ne "" ]; then
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
