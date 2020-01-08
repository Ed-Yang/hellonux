# CMake cross compilation example

This project demostrates a simple example of cmake cross compilation.

The development target is a WiFi router with MTK SoC, but is is easy to cutomize
it to other device, like Raspberry Pi, etc.

To custimize to other device, it could create a new toolchain file like "cmake/openwrt-mtr.cmake" and fill it suitable values for:

```shell
# toolchains
CMAKE_C_COMPILER
CMAKE_CXX_COMPILER
# root path
CMAKE_FIND_ROOT_PATH
```

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

* VSCode (Debian)

Download .deb file and install it.

```shell
dpkg -i code_xxx.deb
```

* PRI ([Reference](https://stackoverflow.com/questions/19162072/how-to-install-the-raspberry-pi-cross-compiler-on-my-linux-host-machine/58559140#58559140))

Setup toolchains:

```shell
cd /tmp
wget https://github.com/Pro/raspi-toolchain/releases/latest/download/raspi-toolchain.tar.gz
sudo mkdir /opt && cd /opt
tar xvf /tmp/raspi-toolchain.tar.gz
```

Copy rootfs:

```shell
cd ~ && mkdir -p raspberrypi/rootfs
rsync -vR --progress -rl --delete-after --safe-links pi@192.168.1.101:/{lib,usr,opt/vc/lib} ~/raspberrypi/rootfs
```

## Environment (Debian/OSX)

## Build

### Build - Debian

```shell
mkdir deb && cd deb
cmake ..
make
```

### Build - OSX

```shell
mkdir osx && cd osx
cmake ..
make
```

### Build - RPI3 (cross compile)

Before building binary, it needs to modify/set the following environment variables according to
your working environment.

```shell
export TARGET=pi@192.168.1.101

export RPI3_C=/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-gcc
export RPI3_CXX=/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-g++
export RPI3_ROOTFS=$HOME/raspberrypi/rootfs
```

```shell
mkdir rpi && cd rpi
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/rpi3.cmake ..
make
```

### Build - Openwrt MTK (cross compile)

Before building binary, it needs to modify/set the following environment variables according to
your working environment.

```shell
export OPENWRT_ROOT=$HOME/workspace/official/openwrt
export STAGING_DIR=$OPENWRT_ROOT/staging_dir/toolchain-mipsel_24kc_gcc-7.5.0_musl
export TARGET=root@10.1.1.1

export MTK_C=$OPENWRT_ROOT/staging_dir/toolchain-mipsel_24kc_gcc-7.5.0_musl/bin/mipsel-openwrt-linux-musl-gcc
export MTK_CXX=$OPENWRT_ROOT/staging_dir/toolchain-mipsel_24kc_gcc-7.5.0_musl/bin/mipsel-openwrt-linux-musl-g++
export MTK_ROOTFS=$OPENWRT_ROOT/staging_dir/target-mipsel_24kc_musl/
```

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

## Remote VSCode Debugging

In host machine:

1. Setup SSH to run gdbserver on target $TARGET.

    RPI:

    ```shell
    ssh -L9091:localhost:9091 $TARGET "gdbserver :9091 ~pi/bin/hellonux"
    ```

    or

    OpenWrt:

    ```shell
    ssh -L9091:localhost:9091 $TARGET "gdbserver :9091 /bin/hellonux"
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

3. Select "RPI3" or "MTK" debug configuration and start debugging.

## Remote GDB Debugging

```shell
info thread
info shared
set sysroot
show arch
b
n
c
```

## Q/A

### mipsel-openwrt-linux-musl-gcc: warning: environment variable 'STAGING_DIR' not defined

### GDB: Unable to find dynamic linker breakpoint function

### Manually-specified variables were not used by the project: CMAKE_TOOLCHAIN_FILE

Just a warning, ignore it.
