#!/usr/bin/bash

#Variabls
VERBOSE=0
INTERVAL=10
NUM=10
COMMAND="Default"

function help {
    cat <<EOL 
Usage $0 [Options] <Command>
Options:
    -i : Intervals in seconds (Default=10)
    -n : Number of tries (Default=10)
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
            COMMAND=$1
            ;;
    esac

done

echo $VERBOSE
echo $INTERVAL
echo $NUM
echo $COMMAND