# This one is important
SET(CMAKE_SYSTEM_NAME Linux)

# Specify the cross compiler
SET(CMAKE_C_COMPILER   $ENV{OPENWRT_ROOT}/staging_dir/toolchain-mipsel_24kc_gcc-7.5.0_musl/bin/mipsel-openwrt-linux-musl-gcc)
SET(CMAKE_CXX_COMPILER $ENV{OPENWRT_ROOT}/staging_dir/toolchain-mipsel_24kc_gcc-7.5.0_musl/bin/mipsel-openwrt-linux-musl-g++)

# Where is the target environment
SET(CMAKE_FIND_ROOT_PATH  $ENV{OPENWRT_ROOT}/staging_dir/target-mipsel_24kc_musl/)

# Search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# For libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
