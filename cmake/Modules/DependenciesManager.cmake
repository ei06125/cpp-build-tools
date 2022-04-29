# Copyright (C) ei06125. All Rights Reserved.
include_guard(GLOBAL)

find_package(Git)
if(NOT Git_FOUND)
  message(FATAL "Git not found")
endif()

# Create dependencies DESTINATION directory
set(DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/external)
if(NOT EXISTS ${DOWNLOAD_DIR})
  file(MAKE_DIRECTORY ${DOWNLOAD_DIR})
endif()

# Version can be Tag or Branch
macro(download_dependency Package URL Version)
  if(NOT EXISTS ${DOWNLOAD_DIR}/${Package})
    message(STATUS "downloading ${Package} at ${URL} version ${Version}")
    execute_process(COMMAND ${GIT_EXECUTABLE} submodule add ${URL} ${Package}
                    WORKING_DIRECTORY ${DOWNLOAD_DIR})
    message(STATUS "checking out version ${Version}")
    execute_process(COMMAND ${GIT_EXECUTABLE} checkout ${Version}
                    WORKING_DIRECTORY ${DOWNLOAD_DIR}/${Package})
    message(STATUS "switching to branch yagen_releases/${Version}")
    execute_process(
      COMMAND ${GIT_EXECUTABLE} switch -c yagen_releases/${Version}
      WORKING_DIRECTORY ${DOWNLOAD_DIR}/${Package})
  else()
    message(STATUS "${Package} already exists")
  endif()
  if(EXISTS ${DOWNLOAD_DIR}/${Package}/CMakeLists.txt)
    add_subdirectory(${DOWNLOAD_DIR}/${Package} EXCLUDE_FROM_ALL)
    else()
    message(WARNING "${Package} does not contain a CMakeLists.txt file")
  endif()
endmacro()

file(STRINGS "Dependencies.txt" DependenciesData)
foreach(Dependency ${DependenciesData})
  # message(STATUS "Dependency: ${Dependency}")
  string(REPLACE "," ";" Dependency ${Dependency})
  download_dependency(${Dependency})
endforeach()
