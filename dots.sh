#!/bin/sh

DOTS_DIR=$(cd $(dirname $0);pwd)
DOTS_FILE=$(basename $0)
for item in $( ls ${DOTS_DIR} | grep -v "${DOTS_FILE}" | grep -v "LICENSE" ); do
	echo ${item}
	ln -s ${DOTS_DIR}/${item} ~/.${item}
done
