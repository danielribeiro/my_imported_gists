#!/bin/bash
# trap "kill -- -$BASHPID" SIGINT SIGTERM EXIT
trap 'exit 42' SIGINT SIGQUIT SIGTERM
function sayit() {
    while [[ 1 ]]
        do echo oi
        sleep 1
    done
}

sayit &
echo it is running
sleep 1
echo i m almost done
kill 0
# kill -HUP -$$
