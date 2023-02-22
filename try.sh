#!/usr/bin/bash

#Try to set values from environment variables otherwise set default values.


if [[ -z $TRY_INTERVAL ]]; then
    INTERVAL=10
else 
    INTERVAL=$TRY_INTERVAL
fi

if [[ -z $TRY_NUMBER ]]; then
    NUM=5
else 
    NUM=$TRY_NUMBER
fi

if [[ -z $TRY_COMMAND ]]; then
    COMMAND=$NULL
else 
    COMMAND=$TRY_COMMAND
fi

VERBOSE=0
SUCCESS=0

function help {
    cat <<EOL 
Usage $0 [Options] <Command>
Options:
    -i : Intervals in seconds (Default=10)
    -n : Number of tries (Default=10)
    -v : Verbose mode
Examples:
$0 <Command>
$0 -v <Command>
$0 -i 5 -v <Command>
$0 -i 4 -n 8 -v <Command>
EOL
}

function is_number {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

if [[ $# -eq 0 ]]; then
    help
    exit 0
fi

while [[ $# -ne 0 ]]; do
    case $1 in

        -h)
            help
            exit 0
            ;;
        -v)
            VERBOSE=1
            shift 1
            ;;
        -i)
            is_number $2
            if [[ $? -ne 0 ]]; then
                help
                exit 1
            else
                INTERVAL=$2
                shift 2               
            fi
            ;;
        -n)
            is_number $2
            if [[ $? -ne 0 ]]; then
                help
                exit 1
            else
                NUM=$2
                shift 2
            fi
            ;;
        *)
            COMMAND=$@
            break
            ;;
    esac

done

if [[ -z $COMMAND ]]; then
    help
    exit 0
fi

for i in $(seq 1 $NUM)
do
    $($COMMAND)
    if [[ $? -eq 0 ]]; then
        SUCCESS=1
        break
    else
        if [[ $VERBOSE -eq 1 ]]; then
            echo "[INFO] Try $i failed and Wating for $INTERVAL seconds ..."
        fi
        sleep $INTERVAL
    fi

done

if [[ $SUCCESS -eq 1 ]]; then
    if [[ $VERBOSE -eq 1 ]]; then
        echo "[INFO] Command was executed Successfully"
    fi
    exit 0
else
    if [[ $VERBOSE -eq 1 ]]; then
        echo "[ERROR] Command execution failed"
    fi
    exit 1
fi
