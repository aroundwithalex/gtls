#!/bin/bash

if !command -v gum &> /dev/null; do
    echo "Gum is not installed. Please use main run script."
    exit 1
done

gum style --align center --border double 'Git configuration'

git config --list | awk -F '=' '{print $1, $2}' | gum table --header 'Key\tValue'
