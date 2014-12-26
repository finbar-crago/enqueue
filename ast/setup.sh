#!/bin/bash

function mk_pjsip {
    PJSIP_URL="http://www.pjsip.org/release/2.3/pjproject-2.3.tar.bz2"
    PJSIP_DIR="/usr/src/pjsip-2.3"

    if [ ! -d "$PJSIP_DIR" ]; then
	mkdir -p $PJSIP_DIR
	wget -O - $PJSIP_DIR | tar xzf - -C $PJSIP_DIR --strip-components=1
    fi

    cd $PJSIP_DIR
    ./configure
}


function mk_asterisk {
    AST_URL="http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz"
    AST_DIR="/usr/src/asterisk-13"

    if [ ! -d "$AST_DIR" ]; then
	mkdir -p $AST_DIR
	wget -O - $AST_URL | tar xzf - -C $AST_DIR --strip-components=1
    fi

    cd $AST_DIR
    ./configure
}

mk_pjsip
