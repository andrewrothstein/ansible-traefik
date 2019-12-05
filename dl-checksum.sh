#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/containous/traefik/releases/download

dl_v1()
{
    local ver=$1
    local os=$2
    local arch=$3
    local suffix=${4:-}
    local platform="${os}-${arch}"
    local mirror=$MIRROR/$ver
    local url=$mirror/traefik_${platform}${suffix}
    local file=$DIR/traefik_${platform}-${ver}${SUFFIX}
    if [ ! -e $file ];
    then
        wget -q -O $file $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `sha256sum $file | awk '{print $1}'`
}

dl_v1_ver()
{
    local ver=$1
    printf "  %s:\n" $ver
    dl_v1 $ver darwin 386
    dl_v1 $ver darwin amd64
    dl_v1 $ver freebsd 386
    dl_v1 $ver freebsd amd64
    dl_v1 $ver linux 386
    dl_v1 $ver linux amd64
    dl_v1 $ver linux arm
    dl_v1 $ver linux arm64
    dl_v1 $ver openbsd 386
    dl_v1 $ver openbsd amd64
    dl_v1 $ver windows 386 .exe
    dl_v1 $ver windows amd64 .exe
}

dl_v2()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local archive_type=${5:-}
    local platform=${os}_${arch}
    local archive=traefik_${ver}_$platform.$archive_type
    local url=$MIRROR/$ver/$archive
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(grep $archive $lchecksums | awk '{print $1}')
}

dl_v2_ver() {
    local ver=$1
    local checksumfile=traefik_${ver}_checksums.txt
    local lchecksums=$DIR/$checksumfile
    local rchecksums=$MIRROR/$ver/$checksumfile

    if [ ! -e $lchecksums ];
    then
        wget -q -O $lchecksums $rchecksums
    fi

    printf "  # %s\n" $rchecksums
    printf "  %s:\n" $ver
    dl_v2 $ver $lchecksums darwin amd64 tar.gz
    dl_v2 $ver $lchecksums freebsd 386 tar.gz
    dl_v2 $ver $lchecksums freebsd amd64 tar.gz
    dl_v2 $ver $lchecksums linux 386 tar.gz
    dl_v2 $ver $lchecksums linux amd64 tar.gz
    dl_v2 $ver $lchecksums linux arm64 tar.gz
    dl_v2 $ver $lchecksums linux armv5 tar.gz
    dl_v2 $ver $lchecksums linux armv6 tar.gz
    dl_v2 $ver $lchecksums linux armv7 tar.gz
    dl_v2 $ver $lchecksums linux ppc64le tar.gz
    dl_v2 $ver $lchecksums openbsd 386 tar.gz
    dl_v2 $ver $lchecksums openbsd amd64 tar.gz
    dl_v2 $ver $lchecksums windows 386 zip
    dl_v2 $ver $lchecksums windows amd64 zip
}

dl_ver() {
    local major_ver=$1
    local minor_ver=$2
    local patch_ver=$3
    local ver=v${major_ver}.${minor_ver}.${patch_ver}
    dl_v${major_ver}_ver $ver
}

dl_ver 2 0 6
