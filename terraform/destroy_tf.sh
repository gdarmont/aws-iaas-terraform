#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo $0: usage: `basename "$0"` dir_prefix
    exit 1
fi

selected_dir=$(echo "$1"*)
cd $selected_dir
echo "###############################################"
echo "!!! DESTROYING directory '$selected_dir' config !!!"
echo "###############################################"
echo "Executing 'terraform destroy'"
echo ""
terraform destroy
cd ..