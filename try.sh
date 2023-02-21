#!/usr/bin/bash

#Variabls
INTERVAL=10
NUM=10
COMMAND="Default"

function help {
    cat <<EOL 
Usage $0 [Options] <Command>
Options:
-i : Intervals in seconds (Default=10)
-n : Number of tries (Default=10)
EOL
}

echo $?
function is_number {
    if [[ $1 =~ [^[0-9]+$] ]]; then
        exit 0
    else
        exit 1
        echo "not number"
    fi
}


while [[ $# -ne 0 ]]
do
    case $1 in
        -i)
        is_number $2
        if [[ $? -ne 1 ]]; then
            INTERVAL=$2
            shift 2
        else
            echo "Bad input"
            help
        fi
        ;;

        -n)
        if [[ $2 -ne 0 ]]; then
            NUM=$2
            shift 2
        else
            echo "Bad input"
            help
        fi
        ;;

        *)
        COMMAND=$1
        ;;
    esac

done

is_number 5
echo $INTERVAL
echo $NUM
echo $COMMAND