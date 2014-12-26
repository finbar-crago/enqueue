#!/bin/bash

function mk_pjsip {
    PJSIP_URL="http://www.pjsip.org/release/2.3/pjproject-2.3.tar.bz2"
    PJSIP_DIR="./build/pjsip-2.3"

    if [ ! -d "$PJSIP_DIR" ]; then
	mkdir -p $PJSIP_DIR
	wget -O - $PJSIP_URL | tar jxf - -C $PJSIP_DIR --strip-components=1
    fi

    cd $PJSIP_DIR

    ./configure CFLAGS=-fPIC CXXFLAGS=-fPIC
    make dep && make && make install
}

function mk_asterisk {
    AST_URL="http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz"
    AST_DIR="./build/asterisk-13"

    if [ ! -d "$AST_DIR" ]; then
	mkdir -p $AST_DIR
	wget -O - $AST_URL | tar xzf - -C $AST_DIR --strip-components=1
    fi

    cd $AST_DIR

    ./configure
    make && make install
}

case "$1" in
    pjsip)
	mk_pjsip
	;;
    asterisk)
	mk_asterisk
	;;
    all)
	mk_pjsip
	mk_asterisk
	;;
    *)
	echo "usage: $0 [ pjsip | asterisk | all]"
    ;;
esac
