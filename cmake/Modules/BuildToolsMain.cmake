# Copyright (C) ei06125. All Rights Reserved.
include_guard(GLOBAL)

set(THIS_DIR ${CMAKE_CURRENT_LIST_DIR})
list(APPEND CMAKE_MODULE_PATH ${THIS_DIR})

include(Logger)
include(HostSystemInformation)

include(StandardProjectSettings)
include(PreventInSourceBuilds)

include(CCache)

include(StaticAnalyzers)

include(CompilerWarnings)

include(Sanitizers)

include(Doxygen)

set(CMAKE_PROJECT_INCLUDE ${THIS_DIR}/CMakeProjectInclude.cmake)
set(CMAKE_PROJECT_INCLUDE_BEFORE ${THIS_DIR}/CMakeProjectIncludeBefore.cmake)
