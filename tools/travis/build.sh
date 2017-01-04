#!/bin/sh

if [ -n "$LAZ_OPT" ]; then
    # Lazarus build (with wine)

    lazbuild $LAZ_OPT ./src/ultrastardx-travis.lpi

elif [ "$TRAVIS_OS_NAME" = "osx" ]; then
    # OSX build

    ./configure --enable-osx-brew
    make macosx-standalone-app

    if [ -r "UltraStarDeluxe.app" ]; then
        link=$(curl --upload-file UltraStarDeluxe.app https://transfer.sh/UltraStarDeluxe.app | sed 's#transfer.sh/#trnasfer.sh/get/#')
        echo "UltraStarDeluxe.app should be available at:"
        echo "    $link"
    fi

else
    # Linux build

    ./autogen.sh
    ./configure
    make

fi
