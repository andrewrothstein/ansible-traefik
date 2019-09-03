#!/usr/bin/env sh
VER=${1:-v1.7.14}
DIR=~/Downloads
MIRROR=https://github.com/containous/traefik/releases/download/$VER

dl()
{
    OS=$1
    PLATFORM=$2
    SUFFIX=${3:-}
    OSP=${OS}-${PLATFORM}
    URL=$MIRROR/traefik_$OSP$SUFFIX
    FILE=$DIR/traefik_$OSP-$VER$SUFFIX
    if [ ! -e $FILE ]
    then
        wget -q -O $FILE $URL
    fi
    printf "    # %s\n" $URL
    printf "    %s: sha256:%s\n" $OSP `sha256sum $FILE | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl darwin 386
dl darwin amd64
dl freebsd 386
dl freebsd amd64
dl linux 386
dl linux amd64
dl linux arm
dl linux arm64
dl openbsd 386
dl openbsd amd64
dl windows 386 .exe
dl windows amd64 .exe


