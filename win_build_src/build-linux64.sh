#!/bin/bash
#
# Linux 32-bit/64-bit

# Copyright (C) polynation games ltd - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Christopher Redden, December 2013

# 64 Bit Version
mkdir -p linux/x86_64

cd luajit
make clean

make -j4 BUILDMODE=static CC="gcc -fPIC -m64"
cp src/libluajit.a ../linux/libluajit.a

cd ../cjson/
make clean
make BUILDMODE=static CC="gcc -fPIC -m64"
cp build/libcjson.a ../linux/x86_64/libcjson.a

cd ..
gcc -fPIC \
	lua_wrap.c \
	cjson/lua_cjson.c \
	-o Plugins/x86_64/libulua.so -shared \
	-I./ \
	-Iluajit/src \
	-Icjson \
	-Wl,--whole-archive \
	linux/libluajit.a \
	linux/x86_64/libcjson.a \
	-Wl,--no-whole-archive -static-libgcc -static-libstdc++
