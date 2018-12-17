#!/usr/bin/env sh
VER=v1.7.6
DIR=~/Downloads
MIRROR=https://github.com/containous/traefik/releases/download/$VER

dl()
{
    OS=$1
    PLATFORM=$2
    SUFFIX=${3:-}
    wget -O $DIR/traefik_$OS-$PLATFORM-$VER$SUFFIX $MIRROR/traefik_$OS-$PLATFORM$SUFFIX
}

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
sha256sum $DIR/traefik_*-$VER*

