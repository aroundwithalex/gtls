# Pulls repositories on mass. Stashes and checks
# out main before pulling. Can lead to side effects
# as it will leave the repo checked out on main. Will
# fail if git or gum are not installed.


#!/bin/bash

ROOT_DIR=~/Projects


if [ ! -d $ROOT_DIR ]; then
    printf "\n${ROOT_DIR} does not exist. Please reset.\n"
    exit 1
fi

if ! command -v git &> /dev/null; then
    printf "\ngit is not installed. Please fix.\n"
    exit 1
fi 

if ! command -v gum &> /dev/null; then
    printf "\ngum is not installed. Please fix.\n"
    exit 1
fi

for dir in "$ROOT_DIR"/*/*/*/; do

    if [ ! -d "$dir/.git" ]; then
        printf "\n$dir is not a git repo\n"
        continue
    fi

    printf "\nPulling ${dir}\n"

    cd "$dir" || continue

    if [ -n "$(git status --porcelain)" ]; then

        printf "\nStashing changes in ${dir}\n"

        git stash -m "Temporary stash to enable pull"
    fi

    git checkout main || git checkout master

    git pull

    printf "\n$dir pulled successfully\n"

done
