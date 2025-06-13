#!/bin/bash

DOTS_DIR_PATH=$(cd $(dirname $0);pwd)
DOTS_DIR_NAME=`basename ${DOTS_DIR_PATH}`

function usage {
    cat << EOS
<usage.1>
Copy files in 'dots' in local host directory to the remote host.

    `basename $0` deploy <ssh_private_key_path> <remote_user> <remote_host> [<remote_dst_dir_path>]

<usage.2>
Setup the files in deployed dots

    `basename $0` setup
EOS

}

function deploy () {
	local SSH_PRIVATE_KEY=$1
	local REMOTE_USER=$2
	local REMOTE_HOST=$3
	local REMOTE_DIR=$4

	if [ -z ${SSH_PRIVATE_KEY} ]; then
		echo -n "Input ssh private key >> "
		read SSH_PRIVATE_KEY
	fi

	if [ -z ${REMOTE_USER} ]; then
		echo -n "Input remote user >> "
		read REMOTE_USER
	fi

	if [ -z ${REMOTE_HOST} ]; then
		echo -n "Input remote host name or IP >> "
		read REMOTE_HOST
	fi

	declare DEFAULT_REMOTE_DIR="~/dots"
	if [ -z ${REMOTE_DIR} ]; then
		echo -n "Input remote destination dir [default:${DEFAULT_REMOTE_DIR}] >> "
		read REMOTE_DIR
		if [ -z ${REMOTE_DIR} ]; then
			REMOTE_DIR=${DEFAULT_REMOTE_DIR}
		fi
	fi

	ssh -i ${SSH_PRIVATE_KEY} ${REMOTE_USER}@${REMOTE_HOST} "mkdir -p ${REMOTE_DIR}"
	scp -i ${SSH_PRIVATE_KEY} -pr `ls ${DOTS_DIR_PATH} | grep -v -E "(\.git|LICENSE)"` ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
}

function setup () {
	for ITEM in $( ls ${DOTS_DIR_PATH} | grep -v "dots.*" | grep -v "LICENSE" ); do
		echo ${ITEM}
		if [ -L ~/.${ITEM} ]; then
			unlink ~/.${ITEM}
		fi
		ln -s ${DOTS_DIR_PATH}/${ITEM} ~/.${ITEM}
	done

	grep ". ~/.bash_aliases" ~/.bashrc 2>&1 >> /dev/null
	if [ $? -ne 0 ]; then
		echo ". ~/.bash_aliases" >> ~/.bashrc
	fi

	if [ ! -d ~/.tmux ];then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
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
