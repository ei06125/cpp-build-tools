#!/bin/bash

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Base Settings
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# ===========================================================================
# Constants
# ===========================================================================

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ANSI color codes
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
COLOR_BOLD_WHITE="\033[1;37m"
COLOR_CYAN="\033[0;36m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RED="\033[0;31m"
COLOR_BOLD_WHITE_BG_RED="\033[1;37;41m"
COLOR_RESET="\033[0m"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Log Levels
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LOG_LEVEL_TRACE=0
LOG_LEVEL_DEBUG=1
LOG_LEVEL_INFO=2
LOG_LEVEL_WARN=3
LOG_LEVEL_ERROR=4
LOG_LEVEL_FATAL=5

BANNER_SECTION=$(printf '%*s\n' 80 | tr ' ' '%')
BANNER_SUBSECTION=$(printf '%*s\n' 80 | tr ' ' '=')
BANNER_SUBSUBSECTION=$(printf '%*s\n' 80 | tr ' ' '~')

# ===========================================================================
# Variables
# ===========================================================================

# Affects logging output (sets to LOG_LEVEL_TRACE). Bypasses --log-level
# Change with --verbose command line argument
verbose=false

# Affects logging output (sets to LOG_LEVEL_DEBUG) Bypasses --log-level
# Change with --debug command line argument
debugging=false

# Affects logging output
# Change with --log-level <LOG_LEVEL> command line argument
current_log_level=$LOG_LEVEL_INFO

# If `true`, it will call test_logging at the end of the script
test_logger=false

# ===========================================================================
# Helper functions
# ===========================================================================

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Usage Function
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
usage() {
    printf "${COLOR_BOLD_WHITE}Usage:${COLOR_RESET} $0 [options]"
    printf "Options:"
    printf "  ${COLOR_CYAN}--verbose${COLOR_RESET}            Enable verbose logging (sets log level to TRACE)."
    printf "  ${COLOR_CYAN}--debug${COLOR_RESET}              Enable debug logging (sets log level to DEBUG)."
    printf "  ${COLOR_CYAN}--log-level <LEVEL>${COLOR_RESET}  Set log level (TRACE=0, DEBUG=1, INFO=2, WARN=3, ERROR=4, FATAL=5)."
    printf "  ${COLOR_CYAN}--test-logger${COLOR_RESET}        Run test logger messages."
    printf "  ${COLOR_CYAN}-h, --help${COLOR_RESET}           Display this help message and exit."
    exit 0
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Logging Functions
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------
# Function to set log level based on user input
set_log_level() {
    case "$1" in
    $LOG_LEVEL_TRACE) current_log_level=$LOG_LEVEL_TRACE ;;
    $LOG_LEVEL_DEBUG) current_log_level=$LOG_LEVEL_DEBUG ;;
    $LOG_LEVEL_INFO) current_log_level=$LOG_LEVEL_INFO ;;
    $LOG_LEVEL_WARN) current_log_level=$LOG_LEVEL_WARN ;;
    $LOG_LEVEL_ERROR) current_log_level=$LOG_LEVEL_ERROR ;;
    $LOG_LEVEL_FATAL) current_log_level=$LOG_LEVEL_FATAL ;;
    *)
        echo "Unknown log level: $1"
        exit 1
        ;;
    esac
}

get_log_level() {
    echo "$current_log_level"
}

# ---------------------------------------------------------------------------
# Function to log messages based on the current log level
log_message() {
    local level=$1
    local message=$2
    if [ "$current_log_level" -le "$level" ]; then
        echo -e "$message"
    fi
}

# ---------------------------------------------------------------------------
# NOTE(PO): even if log-level is 0 (trace), you need to pass verbose
CORE_LOG_TRACE() {
    if "$VERBOSE" = true; then
        log_message $LOG_LEVEL_TRACE "${COLOR_BOLD_WHITE}[T] $1${COLOR_RESET}"
    fi
}

# ---------------------------------------------------------------------------
CORE_LOG_DEBUG() {
    log_message $LOG_LEVEL_DEBUG "${COLOR_CYAN}[D] $1${COLOR_RESET}"
}

# ---------------------------------------------------------------------------
CORE_LOG_INFO() {
    log_message $LOG_LEVEL_INFO "${COLOR_GREEN}[I] $1${COLOR_RESET}"
}

# ---------------------------------------------------------------------------
CORE_LOG_WARN() {
    log_message $LOG_LEVEL_WARN "${COLOR_YELLOW}[W] $1${COLOR_RESET}"
}

# ---------------------------------------------------------------------------
CORE_LOG_ERROR() {
    log_message $LOG_LEVEL_ERROR "${COLOR_RED}[E] $1${COLOR_RESET}"
}

# ---------------------------------------------------------------------------
CORE_LOG_FATAL() {
    log_message $LOG_LEVEL_FATAL "${COLOR_BOLD_WHITE_BG_RED}[F] $1${COLOR_RESET}"
    exit 1
}

# ---------------------------------------------------------------------------
test_logging() {
    CORE_LOG_TRACE "This is a trace message."
    CORE_LOG_DEBUG "This is a debug message."
    CORE_LOG_INFO "This is an info message."
    CORE_LOG_WARN "This is a warning message."
    CORE_LOG_ERROR "This is an error message."
    CORE_LOG_FATAL "This is a fatal message."
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Script Entrypoint
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# ===========================================================================
# Parse command-line arguments
# ===========================================================================

while [[ $# -gt 0 ]]; do
    case $1 in
    --test-logger)
        VERBOSE=true
        set_log_level 0
        test_logging
        shift # past argument
        ;;
    esac
done

if [ -z "${VERBOSE+x}" ]; then
  VERBOSE=$verbose
#   echo "VERBOSE is not defined"
# else
#   echo "VERBOSE is defined"
#   echo "VERBOSE: $VERBOSE"
fi

if [ -z "${DEBUG+x}" ]; then
  DEBUG=$debugging
#   echo "DEBUG is not defined"
# else
#   echo "DEBUG is defined"
#   echo "DEBUG: $DEBUG"
fi

if $DEBUG ; then
    set_log_level "$LOG_LEVEL_DEBUG"
fi

if $VERBOSE; then
    set_log_level "$LOG_LEVEL_TRACE"
fi

CORE_LOG_TRACE "[CORE][logger.sh] Trace is active"
CORE_LOG_DEBUG "[CORE][logger.sh] Debug is active"

if [ "$test_logger" = true ]; then
    test_logging
fi
