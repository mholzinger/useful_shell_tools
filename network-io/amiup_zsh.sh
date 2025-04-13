#!/bin/zsh

# This script checks internet connectivity using TCP instead of ICMP. 
# Many service providers block ICMP (ping) packets, making TCP-based 
# checks more reliable. It uses Zsh's built-in `ztcp` command, which 
# is faster and more efficient than alternatives like Bash's `/dev/tcp` 
# or external tools. `ztcp` is optimized for direct TCP connections 
# within Zsh, avoiding the overhead of spawning external processes or 
# relying on slower shell constructs. The script attempts to connect 
# to a well-known host (google.com) on port 80 (HTTP). If the connection 
# succeeds, a success message is displayed. Otherwise, an error message 
# is shown, and the script exits with a non-zero status.
# Usage: ./amiup.sh

ping_internets() {
    # Define the host and port to test connectivity
    host="google.com"  # The target host to check
    port=80            # The target port (HTTP)
    timeout=1          # Timeout in seconds for the connection attempt

    # Load the zsh TCP networking module
    zmodload zsh/net/tcp
    {
        # Attempt to connect to the host and port using ztcp
        ztcp ${host} ${port} &  # Run ztcp in the background
        ztcp_pid=$!             # Capture the process ID of the ztcp command

        # Start a background sleep process to enforce the timeout
        (sleep ${timeout} && kill -HUP ${ztcp_pid} 2>/dev/null) &
        sleep_pid=$!             # Capture the process ID of the sleep command

        # Wait for the ztcp process to complete
        wait ${ztcp_pid} 2>/dev/null
        result=$?                # Capture the exit status of ztcp

        # Kill the sleep process if ztcp finishes early
        kill -HUP ${sleep_pid} 2>/dev/null

        # Return the result of the ztcp command
        return ${result}
    } && \
    # If the connection was successful, print a success message
    echo "Yay! ${host} is reachable. You're online!" || \
    # If the connection failed, call the error handler
    check_err "Nope - ${host} is not reachable. No internets for you :["
}

check_err() {
    echo "$1"
    exit 1
}

ping_internets
