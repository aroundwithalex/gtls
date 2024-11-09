# Pulls repositories on mass. Stashes and checks
# out main before pulling. Can lead to side effects
# as it will leave the repo checked out on main. Will
# fail if git or gum are not installed.


#!/bin/bash

ROOT_DIR='~/Projects'


if [ ! -d $ROOT_DIR ]; then
    echo "${ROOT_DIR} does not exist. Please reset."
    exit 1
done

if ! command -v git &> /dev/null; then
    echo "git is not installed. Please fix."
    exit 1
done

if ! command -v gum &> /dev/null; then
    echo "gum is not installed. Please fix."
    exit 1
done

for dir in "$ROOT_DIR"/*/; do

    if [ ! -d "$dir/.git" ]; then
        echo "$dir is not a git repo"
        continue
    fi

    gum style --align center --border double "Pulling ${dir}"

    cd "$dir" || continue

    gum style --align center --border double "Stashing changes in ${dir}"

    git stash -m "Temporary stash to enable pull"

    git checkout main

    git pull

    gum style --align center --border double "${dir} pulled successfully."
done
