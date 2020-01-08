# CMake cross compilation example

## Prerequsite

* CMake/GDB

```shell
sudo apt update
sudo apt install -y cmake gdb-multiarch
```

* Googletest

```shell
cd tmp
git clone https://github.com/google/googletest.git
cd googletest/
mkdir build && cd build/
cmake ..
make
sudo make install
```

## Environment (Debian/OSX)

```shell
export OPENWRT_ROOT=/home/edward/workspace/official/openwrt
export STAGING_DIR=$OPENWRT_ROOT/staging_dir/toolchain-mipsel_24kc_gcc-7.5.0_musl
export TARGET=root@10.1.1.1
```

## Build

### Build - Debian

mkdir deb && cd deb
cmake ..
make

### Build - OSX

mkdir deb && cd deb
cmake ..
make

### Build - Openwrt MTK (cross compile)

```shell
mkdir wrt && cd wrt
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/openwrt-mtk.cmake ..
make
```

### Build - Openwrt Package

```shell
In openwrt project folder, run "make menuconfig" and check the "Utilities/hellonux", save and exit.
make package/hellonux/compile V=s
```

## Remote Debugging

### Openwrt MTK

In host machine:

1. Use SSH to run gdbserver on target 10.1.1.1.

```shell
ssh -L9091:localhost:9091 root@10.1.1.1  gdbserver :9091 /bin/hellonux
```

2. Launch VSCode:

```shell
code [--disable-gpu] [-n <folder>] &

ex:

code --disable-gpu -n hellonux
```

If run VSCode in VM, sometimes, it will show all white screen, it can use "--disable-gpu" to make it display correctly.

In debug console, it can issue th GDB command with "-exec" prefix, for example:

```shell
-exec info thread
```

3. Select "OpenWrt" debug configuration and start debugging.

## Usefull GDB Commands

info thread
info shared
set sysroot
show arch

## Q/A

### mipsel-openwrt-linux-musl-gcc: warning: environment variable 'STAGING_DIR' not defined

### GDB: Unable to find dynamic linker breakpoint function

### Manually-specified variables were not used by the project: CMAKE_TOOLCHAIN_FILE

Just a warning, ignore it.



    





