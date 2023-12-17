#! /bin/bash

echo $1;
if [[ $1 = "master" ]]; then
    echo "error"
    exit 1
fi

echo "okay"
exit 0

