#!/bin/bash

uninstall_docker(){}

uninstall(){}

while [ $# > 0 ]; do
    case "$1" in
        -n|--name)
            task=$2
            uninstall $task
            exit 0
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            exit 1
            ;;
    easc
done
