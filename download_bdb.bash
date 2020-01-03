#!/bin/bash

TARGETFILE=db-6.1.38.NC.tar.gz
TARGETURL=https://download.oracle.com/otn/berkeley-db/$TARGETFILE
SRCDIR=$PWD/depends/sources
STAMPDIR=$SRCDIR/download-stamps

[ -f $SRCDIR/$TARGETFILE ] && exit 0

mkdir -p $STAMPDIR && \
    wget --no-use-server-timestamps $TARGETURL -O $SRCDIR/$TARGETFILE && \
    pushd $SRCDIR && \
    shasum -a 256 $TARGETFILE > $STAMPDIR/.stamp_fetched-bdb-${TARGETFILE}.hash && \
    popd
