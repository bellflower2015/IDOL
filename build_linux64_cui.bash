#!/bin/bash

./download_bdb.bash

DEPENDS=$PWD/depends/x86_64-pc-linux-gnu

STATIC=1 \
    USE_BUILD_INFO=1 \
    USE_UPNP=1 \
    CXXFLAGS="-I${DEPENDS}/include" \
    LDFLAGS="-I${DEPENDS}/LIB" \
    BOOST_LIB_SUFFIX=-mt-x64 \
    BOOST_THREAD_LIB_SUFFIX=-mt-x64 \
    BOOST_INCLUDE_PATH=$DEPENDS/include/boost \
    BOOST_LIB_PATH=$DEPENDS/lib \
    OPENSSL_INCLUDE_PATH=$DEPENDS/include/openssl \
    OPENSSL_LIB_PATH=$DEPENDS/lib \
    BDB_INCLUDE_PATH=$DEPENDS/include \
    BDB_LIB_PATH=$DEPENDS/lib \
    MINIUPNPC_INCLUDE_PATH=$DEPENDS/include \
    MINIUPNPC_LIB_PATH=$DEPENDS/lib \
    QMAKE_LRELEASE=$DEPENDS/native/bin/lrelease \
    make -C src -f makefile.unix -j $(nproc) && \
    strip src/IDOLd
