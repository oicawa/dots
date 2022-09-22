#!/bin/bash

DOTS_DIR_PATH=$(cd $(dirname $0);pwd)
DOTS_DIR_NAME=`basename ${DOTS_DIR_PATH}`

function deploy () {
	declare REMOTE_USER=$1
	declare REMOTE_HOST=$2

	if [ -z ${REMOTE_USER} ]; then
		echo -n "Input remote user on the remote host>> "
		read REMOTE_USER
	fi

	if [ -z ${REMOTE_HOST} ]; then
		echo -n "Input remote host name or remote host IP address >> "
		read REMOTE_HOST
	fi

	mkdir ./.dummy
	scp -pr ./.dummy ${REMOTE_USER}@${REMOTE_HOST}:~/${DOTS_DIR_NAME} 
	rmdir ./.dummy

	for ITEM in $( ls ${DOTS_DIR_PATH} ); do
		echo ${ITEM}
		scp -pr ${DOTS_DIR_PATH}/${ITEM} ${REMOTE_USER}@${REMOTE_HOST}:~/${DOTS_DIR_NAME} 
	done
}

function setup () {
	for ITEM in $( ls ${DOTS_DIR_PATH} | grep -v "dots.*" | grep -v "LICENSE" ); do
		if [ ! -L ~/.${ITEM} ]; then
			echo ${ITEM}
			ln -s ${DOTS_DIR_PATH}/${ITEM} ~/.${ITEM}
		fi
	done
}

function operate () {
	declare MENU=$1
	declare REST_ARGS=(${@:2})
	case "${MENU}" in
		"deploy" ) deploy ${REST_ARGS[@]};;
		"setup"  ) setup ;;
        * )        echo "Illegal menu." ;;
	esac
}

function main () {
	declare MENU=$1
	declare REST_ARGS=(${@:2})
	if [ ! -z ${MENU} ]; then
		operate ${MENU}	${REST_ARGS[@]}
		exit 0
	fi
	# Input menu
	echo "----- Menu ------------------------------------"
	echo "deploy : Deploy whole dots directory resources."
	echo "setup  : Setup all dots directories."
	echo "-----------------------------------------------"
	echo -n "Input menu >> "
	read ITEM ARGS
	operate ${ITEM} ${ARGS[@]}
}

main ${@:1}
