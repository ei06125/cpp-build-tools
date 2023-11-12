#!/bin/bash

# ============================================================================
# Build cmake targets for macOS using clang compiler on dev configuration
# ============================================================================

# get the directory where the script is located
THIS_SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# import git utilities
GIT_UTILITIES_SCRIPT_PATH=$THIS_SCRIPT_DIR/../git/utils/utilities.sh
test -f $GIT_UTILITIES_SCRIPT_PATH || (echo "File not found: $GIT_UTILITIES_SCRIPT_PATH" && exit 1)
source $GIT_UTILITIES_SCRIPT_PATH || (echo "Failed to source $GIT_UTILITIES_SCRIPT_PATH" && exit 1)

# detect if this tools folder is a submodule or not
IS_SUBMODULE=$(git_is_submodule; echo $?)

# getting the root level directory of the project
PROJECT_ROOT_DIR=$(git rev-parse --show-toplevel)
if [[ $IS_SUBMODULE == 1 ]]; then
    cd "${PROJECT_ROOT_DIR}/.."
    PROJECT_ROOT_DIR=$(git rev-parse --show-toplevel)
fi

# import logger
source ${PROJECT_ROOT_DIR}/tools/scripts/utils/logger.sh

log_info "Testing MacOS Continuous Integration"
log_info "Building DEBUG configuration"
cd ${PROJECT_ROOT_DIR}
cmake --preset=macos-clang-debug -B out/build/macos-clang-debug
cd out/build/macos-clang-debug
cmake --build . --config Debug --target RUN_ALL_TARGETS
# sleep 2 # sleeping for 2 seconds
log_info "Running unit tests"
./myproject_unit_tests
log_info "Running main tests"
./myproject_main_tests

log_info "Building DEVELOPMENT configuration"
cd ${PROJECT_ROOT_DIR}
cmake --preset=macos-clang-dev -B out/build/macos-clang-dev
cd out/build/macos-clang-dev
cmake --build . --config Development --target RUN_ALL_TARGETS
# sleep 2 # sleeping for 2 seconds
log_info "Running unit tests"
./myproject_unit_tests
log_info "Running main tests"
./myproject_main_tests

log_info "Building DISTRIBUTION configuration"
cd ${PROJECT_ROOT_DIR}
cmake --preset=macos-clang-release -B out/build/macos-clang-release
cd out/build/macos-clang-release
cmake --build . --config Release --target RUN_ALL_TARGETS
# sleep 2 # sleeping for 2 seconds
log_info "Running unit tests"
./myproject_unit_tests
# sleep 2 # sleeping for 2 seconds
log_info "Running main tests"
./myproject_main_tests

log_info "Finished MacOS Continuous Integration"
log_info "Cleaning up"
cd ${PROJECT_ROOT_DIR}
rm -rf out/build/macos-clang-debug
rm -rf out/build/macos-clang-dev
rm -rf out/build/macos-clang-release
