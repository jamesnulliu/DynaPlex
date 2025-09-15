# PREAMBLE
cmake_minimum_required(VERSION 3.21)
project("DynaPlexSuite" CXX)

# Common utility functions:
include(${PROJECT_SOURCE_DIR}/cmake/utils/common.cmake)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_EXECUTABLE_SUFFIX ".exe")

# PROJECT WIDE SETUP
# list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
include(${PROJECT_SOURCE_DIR}/cmake/libraries/libpython.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/libraries/libtorch.cmake)

find_package(MPI REQUIRED)
find_package(Threads REQUIRED)

set_default_values(
    dynaplex_enable_pythonbindings ON
    dynaplex_enable_tests OFF
    DYNAPLEX_IO_ROOT_DIR "${PROJECT_SOURCE_DIR}"
)

# MAIN TARGETS
add_subdirectory(src/lib)

# include examples unless this project is included as part of bigger project.
if(PROJECT_IS_TOP_LEVEL AND NOT dynaplex_enable_pythonbindings)
    add_subdirectory(src/executables)
    set(BUILD_GMOCK OFF CACHE BOOL "" FORCE)

    if(dynaplex_enable_tests)
        enable_testing()
        # add_subdirectory(src/extern/googletest)
        find_package(GTest REQUIRED)
        add_subdirectory(src/tests)
    endif(dynaplex_enable_tests)
endif()
