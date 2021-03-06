# This one is important
SET(CMAKE_SYSTEM_NAME Linux)

# Specify the cross compiler
SET(CMAKE_C_COMPILER   $ENV{MTK_C})
SET(CMAKE_CXX_COMPILER $ENV{MTK_CXX})

# Where is the target environment
SET(CMAKE_FIND_ROOT_PATH  $ENV{MTK_ROOTFS})

# Search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# For libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
