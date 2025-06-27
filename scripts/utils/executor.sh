#!/bin/bash

# Function to execute a command based on the VERBOSE constant
RUN_CMD() {
    local command="$1"
    if "$VERBOSE"; then
        eval "$command"
    else
        eval "$command" > /dev/null 2>&1
    fi
}
