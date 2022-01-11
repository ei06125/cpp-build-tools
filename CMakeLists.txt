cmake_minimum_required(VERSION 3.21)
project(
  test_cmake_host_system_information
  VERSION 0.1.0.0
  DESCRIPTION "Testing cmake_host_system_information"
  HOMEPAGE_URL ""
  LANGUAGES NONE)

set(ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})
include(${ROOT_DIR}/cmake/Modules/BuildToolsMain.cmake)
