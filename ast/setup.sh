#!/bin/bash

AST_URL="http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz"
AST_DIR="/usr/src/asterisk-13"

if [ ! -d "$DIRECTORY" ]; then
    mkdir -p $AST_DIR
    wget -O - $AST_URL | tar xzf - -C $AST_DIR --strip-components=1
fi

cd $AST_DIR
./configure
