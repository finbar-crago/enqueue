#!/bin/bash

AST_URL="http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz"
AST_DIR="/usr/src/asterisk-13"

#mkdir -p $AST_DIR
#curl -L $AST_URL | tar xzf - -C $AST_DIR --strip-components=1

cd $AST_DIR
./configure
