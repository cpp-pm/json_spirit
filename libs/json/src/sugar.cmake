# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED JSON_SPIRIT_LIBS_JSON_SRC_SUGAR_CMAKE_)
  return()
else()
  set(JSON_SPIRIT_LIBS_JSON_SRC_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    JSON_SPIRIT_SOURCES
    io.cpp
    value.cpp
)
