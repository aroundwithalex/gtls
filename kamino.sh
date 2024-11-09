# Mass cloner from GitHub. Places cloned repositories
# in a couple of directories depending on whether they
# are public, private or forks.

#! /bin/bash

# Define some metadata
USER="aroundwithalex"
API_ROOT="https://api.github.com"
PAGE=1
PER_PAGE=100

PUBLIC_DIR="~/Projects/Public"
PRIVATE_DIR="~/Projects/Private"
FORKS_DIR="~/Projects/Forks"

mkdir -p "$PUBLIC_DIR" "$PRIVATE_DIR" "$FORKS_DIR"

if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please fix."
    exit 1
done

if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please fix."
    exit 1
done

if ! command -v gum &> /dev/null; then
    echo "gum is not installed. Please fix."
    exit 1
done

gum style --align center --border double "Cloning all Git repos for ${USER}"


GH_URL="${API_ROOT}/users/${USER}/repos?per_page=${PER_PAGE}&page=${PAGE}"

while true; do
    REPOS=$(curl -s "${GH_URL}" | jq -c '.[]')

    if [[ -z "$REPOS" ]]; then
        gum style --align center "There are no Git repos left to clone"
        break
    fi

    gum style --align center "${REPOS}" | while read -r REPO_JSON; do
        CLONE_URL=$(echo "$REPO_JSON" | jq -r '.clone_url')
        IS_FORK=$(echo "$REPO_JSON" | jq -r '.fork')
        IS_PRIVATE=$(echo "$REPO_JSON" | jq -r '.private')
        REPO_NAME=$(basename "$CLONE_URL" .git)

        if [[ "$IS_FORK" == "true" ]]; then
            TARGET_DIR="$FORKS_DIR"
        elif [[ "$IS_PRIVATE" == "true" ]]; then
            TARGET_DIR="$PRIVATE_DIR"
        else
            TARGET_DIR="$PUBLIC_DIR"
        fi

        echo "Cloning $REPO_NAME into $TARGET_DIR "
        git clone "$CLONE_URL" "$TARGET_DIR/$REPO_NAME"
    done

    ((PAGE++))
done

gum style --align center --border double "Cloning completed"

