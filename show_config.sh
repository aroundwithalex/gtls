# Prints git configuration data in a table formatted
# by gum. Fails if gum is not installed.



#!/bin/bash

if !command -v gum &> /dev/null; then
    echo "Gum is not installed. Please use main run script."
    exit 1
fi

config=$(git config --list)

data=""
while IFS='=' read -r key value; do
    data+="$key,$value\n"
done <<< "$config"

gum style --align center --border double "Git Config"

echo -e "$data" | gum table -c "Key,Value" --height=20 --widths 20,40
