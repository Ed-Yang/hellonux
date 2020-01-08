cmake_minimum_required(VERSION 3.0.2)

project(hellonux)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

SET(CMAKE_BUILD_TYPE Debug)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

SET(TARGET $ENV{TARGET})


# only perform gtest on host env
IF ("${CMAKE_TOOLCHAIN_FILE}" STREQUAL "")
    # Googletest
    MESSAGE("Finding googletest libs")
    enable_testing()
    find_package(GTest REQUIRED)
    find_package(GMock REQUIRED)
    include_directories(${GTEST_INCLUDE_DIRS})
ENDIF()

# include
include_directories("./src")

# link
IF (APPLE)
    SET( GCC_COVERAGE_COMPILE_FLAGS "-Wall")
    SET(GCC_COVERAGE_LINK_FLAGS "")
ELSE ()
    SET( GCC_COVERAGE_COMPILE_FLAGS "-Wall")
    SET(GCC_COVERAGE_LINK_FLAGS "-pthread")
ENDIF()

SET( CMAKE_C_FLAGS  ${CMAKE_C_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS})
SET( CMAKE_CXX_FLAGS  ${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS})
SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}" )

# lib src
file(GLOB LIBSRC "./src/sysver.cpp")
add_library(sysver STATIC ${LIBSRC})

add_executable(hellonux "./src/hellonux.cpp")
target_link_libraries(hellonux sysver)

IF ("${CMAKE_TOOLCHAIN_FILE}" STREQUAL "")
    MESSAGE("Build googlest program ....")
    add_executable(gt_sysver "./src/gt_sysver.cpp")
    target_link_libraries(gt_sysver sysver ${GTEST_BOTH_LIBRARIES})
ENDIF()

MESSAGE("---->" ${CMAKE_TOOLCHAIN_FILE})

IF (DEFINED CMAKE_TOOLCHAIN_FILE)
    add_custom_command(TARGET hellonux
        # Run after all other rules within the target have been executed
        POST_BUILD
        COMMAND scp hellonux ${TARGET}:/bin
        COMMENT "This command will be executed after building hellonux"
        VERBATIM
    )
ENDIF()
