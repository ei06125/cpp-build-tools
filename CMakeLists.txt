cmake_minimum_required(VERSION 3.21)
project(
  test_cmake_host_system_information
  VERSION 0.1.0.0
  DESCRIPTION "Testing cmake_host_system_information"
  HOMEPAGE_URL ""
  LANGUAGES NONE)

include(CMakePrintHelpers)

include(BuildTools/cmake/HostSystemInformation.cmake)
