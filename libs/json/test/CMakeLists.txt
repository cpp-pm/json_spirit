# CMake build control file for json_spirit unit tests
# Copyright (C) 2013 Jeff Trull <edaskel@att.net>
# Copyright (C) 2014 Ruslan Baratov <ruslan_baratov@yahoo.com>
#
#   Distributed under the Boost Software License, Version 1.0. (See accompanying
#   file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#

# CMake build control file for json_spirit tests

foreach(srcname ${JSON_SPIRIT_UT_SOURCES})
  get_filename_component(tname "${srcname}" NAME_WE)
  add_executable(${tname} ${srcname})
  target_link_libraries(${tname} json ${Boost_LIBRARIES})
  add_test(${tname} ${tname})
endforeach()
