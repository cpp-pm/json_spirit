# Main CMake build control file for json_spirit
# Copyright (C) 2013 Jeff Trull <edaskel@att.net>
# Copyright (C) 2014 Ruslan Baratov <ruslan_baratov@yahoo.com>
#
#   Distributed under the Boost Software License, Version 1.0. (See accompanying
#   file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#

# CMake build control file for json_spirit
# Created following settings in Jamroot and libs/json/test/Jamfile

cmake_minimum_required(VERSION 2.8)

project(JsonSpirit)

### Build Options ###
option(JSON_SPIRIT_BUILD_TESTS "Build unit-tests" OFF)

### Download dependencies ###
include(HunterGate.cmake)
hunter_add_package(Boost COMPONENTS test)
hunter_add_package(Sugar)

### Find dependencies ###
set(Boost_USE_STATIC_LIBS ON)
find_package(Boost REQUIRED unit_test_framework)

### - ###
include("${SUGAR_ROOT}/cmake/Sugar")
include(sugar_groups_generate)
include(sugar_include)

### Target sources. Init variables: ###
#   JSON_SPIRIT_SOURCES
#   JSON_SPIRIT_UT_SOURCES
sugar_include("./")

### Source groups (MSVC, Xcode) ###
sugar_groups_generate(${JSON_SPIRIT_SOURCES})
sugar_groups_generate(${JSON_SPIRIT_UT_SOURCES})

if(CMAKE_COMPILER_IS_GNUCXX)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ftemplate-depth=300")
endif()

if(MSVC)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4996")
endif()

### Targets ###
add_library(json ${JSON_SPIRIT_SOURCES})

# Enable V3 of Phoenix by default. V2 has some issues with C++11
# compilers.
target_compile_definitions(json PUBLIC BOOST_SPIRIT_USE_PHOENIX_V3=1)

set(INCL_DEST "include")

target_include_directories(json PUBLIC ${Boost_INCLUDE_DIRS})
target_include_directories(
    json
    PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>"
    "$<INSTALL_INTERFACE:${INCL_DEST}>"
)

### Testing ###
if(JSON_SPIRIT_BUILD_TESTS)
  enable_testing()
  add_subdirectory(libs/json/test)
endif()

### Install ###
set(CONF_DEST "lib/cmake/JsonSpirit")
set(LIBR_DEST "lib")

include(CMakePackageConfigHelpers)
set(json_spirit_config "${CMAKE_CURRENT_BINARY_DIR}/JsonSpiritConfig.cmake")
configure_package_config_file(
    "JsonSpiritConfig.cmake.in"
    ${json_spirit_config}
    INSTALL_DESTINATION ${CONF_DEST}
    PATH_VARS CONF_DEST
)

install(FILES "${json_spirit_config}" DESTINATION ${CONF_DEST})
install(TARGETS json DESTINATION ${LIBR_DEST} EXPORT JsonSpiritTargets)
install(
    DIRECTORY "ciere"
    DESTINATION ${INCL_DEST}
    FILES_MATCHING
    PATTERN "*.hpp"
)
install(EXPORT JsonSpiritTargets DESTINATION ${CONF_DEST})
