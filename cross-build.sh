# arm 平台交叉编译脚本
# TODO：兼容x86(32 & 64 bit)
# 
#!/bin/bash
set -e

QEMU_VERSION="${QEMU_VERSION:-v3.0.0}"

ARCH=arm32v7 # arm64v8

main(){
if [[ $# != 1 ]]; then
    usage
    exit
fi

docker_prepare $@

docker_build

}

usage() {
    echo "Usage:"
    echo "$0 arm | arm64"
}

prepare_qemu(){
    sudo apt-get install qemu-user-static
}

# 环境准备
docker_prepare(){
    arch=$@

    if [[ $arch == arm ]]; then
        ARCH=arm32v7
    elif [[ $arch == arm64 ]]; then
        ARCH=arm64v8
    else
        echo "$arch not support" 
        exit
    fi
    
    echo "build arch: " $ARCH
}

docker_build(){
    echo "setting env..."
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes  || exit 0
    echo "building..."
    docker build -t metaverse -f Dockerfile.cross --build-arg BUILD_FROM=$ARCH .  || exit 0
    
    docker run -d --rm --name foobar metaverse || exit 0
    mkdir -p output
    docker cp metaverse:/usr/local/lib output
    docker cp metaverse:/usr/local/bin output
    docker rm -f foobar
    
    echo "Done"
}

main $@
