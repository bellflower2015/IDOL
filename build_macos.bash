#!/bin/bash

./download_bdb.bash

DEPENDS=depends/x86_64-apple-darwin11
SDK=$HOME/MacOSX10.11.sdk

make -C depends \
    HOST=x86_64-apple-darwin11 \
    DARWIN_SDK_PATH=$SDK \
    -j$(getconf _NPROCESSORS_ONLN) && \
    $DEPENDS/native/bin/qmake \
    USE_BUILD_INFO=1 \
    USE_QRCODE=1 \
    USE_UPNP=1 \
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
    idol-qt.pro && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    strip IDOL.app/Contents/MacOS/IDOL && \
    QTDIR=$DEPENDS python contrib/macdeploy/macdeployqtplus IDOL.app \
    -dmg \
    -fancy contrib/macdeploy/fancy.plist \
    -no-plugins \
    -verbose 3
