#!/bin/bash

echo "start to build project glm"

# download third_party
[ ! -d build ] && mkdir -p build
cd build
if [ ! -d glog ];then
    git clone https://github.com/google/glog.git
    cd glog && git pull origin master
    cd -
else
    cd glog && git pull origin master
    cd -
fi

if [ ! -d gflags ];then
    git clone https://github.com/gflags/gflags.git
    cd gflags && git pull origin master && git submodule update --init
    cd -
else
    cd gflags && git pull origin master && git submodule update --init
    cd -
fi

if [ ! -d protobuf ];then
    git clone https://github.com/protocolbuffers/protobuf.git
    cd protobuf && git pull origin master && git submodule update --init
    cd -
else
    cd protobuf && git pull origin master && git submodule update --init
    cd -
fi

# check cross tools
export PATH=/usr/local/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin:${PATH}
export THIRD_PARTY_INSTALL_PATH=${PWD}/lib

which arm-linux-gnueabihf-g++

# cross compile glog
echo "start to build glog"
[ ! -d glog ] && echo "do not exist glog directories, exit -1" && exit -1
cd glog && ./autogen.sh
[ ! -d ${THIRD_PARTY_INSTALL_PATH} ] && mkdir -p ${THIRD_PARTY_INSTALL_PATH}
./configure --host=arm-linux CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ --prefix=${THIRD_PARTY_INSTALL_PATH}
make -j2
make install
cd -
echo "build glog success"

# cross compile gflags
[ ! -d gflags ] && echo "do not exist gflags directories, exit -1" && exit -1

# cross compile protobuf
[ ! -d protobuf ] && echo "do not exist protobuf directories, exit -1" && exit -1

echo "build project glm success"