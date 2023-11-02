#!/bin/bash

if [ $# -lt 2 ]; then
    printf "Usage: rpiz_exec.sh <ssh_destination> <kernel_module_file>\n\n\tssh_destination\n\t\tThe destination for connecting with SSH in format user@hostname e.g. pi@raspberrypi.local\n\n\tkernel_module_file\n\t\tThe compiled kernel module file to run (.ko)";
    exit;
fi

KO_FILE="$2"
KO_FILE_NAME="$(basename $2)"

scp "$KO_FILE" "$1:~/mods/${KO_FILE_NAME}"
ssh -t $1 'mkdir -p mods; cd mods; bash -l'