#!/bin/bash

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Environmental Settings
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# ===========================================================================
# Constants
# ===========================================================================
readonly __PATH__=$(realpath $0)
readonly __DIR__=$(dirname $__PATH__)
readonly __FILE__=$(basename $__PATH__)

# ===========================================================================
# Options
# ===========================================================================

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Command Line Variables
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
help_requested=false
invalid_argument=false
verbose=false
debug=false

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Argument Parsing
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
        help_requested=true
        shift # past argument
        ;;
    -v | --verbosea)
        verbose=true
        shift # past argument
        ;;
    -d | --debug)
        debug=true
        shift # past argument
        ;;
    ? | *)
        invalid_argument=true
        help_requested=true
        shift
        ;;
    esac
done

readonly VERBOSE=$verbose
readonly DEBUG=$debug

# ===========================================================================
# Imports
# ===========================================================================
source "$__DIR__/logger.sh"

# ===========================================================================
# Helper Functions
# ===========================================================================

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Logging Customization
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------
LOG_TRACE() {
    if $VERBOSE; then
        CORE_LOG_TRACE "[$__FILE__] $1"
    else
        CORE_LOG_TRACE "$1"
    fi
}

# ---------------------------------------------------------------------------
LOG_DEBUG() {
    if $VERBOSE; then
        CORE_LOG_DEBUG "[$__FILE__] $1"
    else
        CORE_LOG_DEBUG "$1"
    fi
}

# ---------------------------------------------------------------------------
LOG_INFO() {
    if $VERBOSE; then
        CORE_LOG_INFO "[$__FILE__] $1"
    else
        CORE_LOG_INFO "$1"
    fi
}

# ---------------------------------------------------------------------------
LOG_WARN() {
    if $VERBOSE; then
        CORE_LOG_WARN "[$__FILE__] $1"
    else
        CORE_LOG_WARN "$1"
    fi
}

# ---------------------------------------------------------------------------
LOG_ERROR() {
    if $VERBOSE; then
        CORE_LOG_ERROR "[$__FILE__] $1"
    else
        CORE_LOG_ERROR "$1"
    fi
}

# ---------------------------------------------------------------------------
LOG_FATAL() {
    if $VERBOSE; then
        CORE_LOG_FATAL "[$__FILE__] $1"
    else
        CORE_LOG_FATAL "$1"
    fi
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Script Entrypoint
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LOG_TRACE "This is a trace message."
LOG_DEBUG "This is a debug message."
LOG_INFO "This is an info message."
LOG_WARN "This is a warning message."
LOG_ERROR "This is an error message."
LOG_FATAL "This is a fatal message."