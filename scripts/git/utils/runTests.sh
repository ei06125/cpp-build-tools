#!/bin/bash

# ============================================================================
# Script setup
# ============================================================================

# navigate to project root directory
git_dir=$(git rev-parse --show-toplevel)
cd $git_dir 1>runTests.log

# add logger to the scope
source $(pwd)/tools/scripts/git/utils/logger.sh

CLEAN_BUILD=0

while getopts 'f' flag;
do
    case "${flag}" in
        f)
            CLEAN_BUILD=1
        ;;
        ?)
            echo "script usage: $(basename \$0) [-f]" >&2
            exit 1
        ;;
    esac
done

CMAKE_TOOLCHAIN_FILE_DIR=$(pwd)/tools/vcpkg/scripts/buildsystems
CMAKE_BINARY_DIR=build/CI/
CMAKE_BUILD_TYPE=Release

if [[ $CLEAN_BUILD != 0 ]]; then
    log_warn "Removing previous CI build ..."
    rm -rf $CMAKE_BINARY_DIR
    log_warn "Removing previous CI build -- DONE"
fi

# ============================================================================
# CMake Generating, building and testing stages
# ============================================================================

# ----------------------------------------------------------------------------
# Generating
# ----------------------------------------------------------------------------

CMAKE_CTestTestfile=$CMAKE_BINARY_DIR/CTestTestfile.cmake
if [[ ! -f "$CMAKE_CTestTestfile" ]]; then
    log_info "Generating build system..."
    cmake -S . -B $CMAKE_BINARY_DIR -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE -DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE_DIR/vcpkg.cmake -DCMAKE_CXX_COMPILER="clang++"
    if [[ "$?" != 0 ]]; then
        log_error "Generating - FAILED"
        exit 1
    else
        log_info "Generating build system -- done"
    fi
fi

# -----------------------------------------------------------------------------
# Building
# -----------------------------------------------------------------------------
log_info "Building..."
cmake --build $CMAKE_BINARY_DIR --config $CMAKE_BUILD_TYPE
if [[ "$?" != 0 ]]; then
    log_error "Building - FAILED"
    exit 1
fi

# -----------------------------------------------------------------------------
# Testing
# -----------------------------------------------------------------------------

log_info "Testing..."
ctest --test-dir $CMAKE_BINARY_DIR -C $CMAKE_BUILD_TYPE --output-on-failure --timeout 10
if [[ "$?" != 0 ]]; then
    log_error "Testing - FAILED"
    exit 1
else
    log_info "Testing - DONE"
fi

# =============================================================================
# Clean up
# =============================================================================

# return to previous cwd
cd - 1> runTests.log
rm runTests.log
