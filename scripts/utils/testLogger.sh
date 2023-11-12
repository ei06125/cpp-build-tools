#!/bin/bash

# get the directory where the script is located
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# import git utilities
GIT_UTILITIES_SCRIPT_PATH=$SCRIPT_DIR/../git/utils/utilities.sh
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

while getopts 'v' flag;
do
    case "${flag}" in
        v)
            echo "VERBOSE"
            CMAKE_CURRENT_LOG_LEVEL=CMAKE_LOG_LEVEL_TRACE
        ;;
        ?)
            echo "script usage: $(basename \$0) [-v]" >&2
            exit 1
        ;;
    esac
done

log_trace "Testing LOG TRACE"
log_debug "Testing LOG DEBUG"
log_info "Testing LOG INFO"
log_warn "Testing LOG WARN"
log_error "Testing LOG ERROR"
log_fatal "Testing LOG FATAL"

# will not print this message
log_info "Exiting..."
