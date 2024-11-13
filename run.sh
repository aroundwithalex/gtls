# Run script for gtls

#! /bin/bash

printf "\nWelcome to gtls. Checking system...\n"

if  [[ $(uname) == "Darwin" ]]; then
    PKG_MANAGER="brew"
elif [[ $(uname) == "Linux" ]]; then
    PKG_MANAGER="sudo apt-get"
else
    echo "Unrecognised OS: ${uname}. Exiting."
    exit 1
fi

if ! command -v $PKG_MANAGER &> /dev/null; then
    printf "${PKG_MANAGER} not found. Exiting."
    exit 1
fi

printf "\nUpdating packages managed by $PKG_MANAGER...\n"

$PKG_MANAGER update
$PKG_MANAGER upgrade

if ! command -v gum &> /dev/null; then
    printf "\nGum not found. Installing. \n"
    $PKG_MANAGER install gum
fi

if ! command -v git &> /dev/null; then
    printf "\nGit not found. Installing.\n"
    $PKG_MANAGER install git
fi 

if ! command -v curl &> /dev/null; then
    printf "\ncurl not found. Installing.\n"
    $PKG_MANAGER install curl
fi

if ! command -v jq &> /dev/null; then
    prtinf "\njq not found. Installing.\n"
    $PKG_MANAGER install jq
fi 

if ! command -v gh &> /dev/null; then
    printf "\ngh not found. Installing.\n"
    $PKG_MANAGER install gh
fi

printf "\nMaking scripts executable\n"

for script in ${pwd}/*; do
    chmod +x $script
done

SCRIPT=$(gum choose --height 15 "Show config" "Pull all repos" "Clone all repos")

if [[ ${SCRIPT} == "Show config" ]]; then
    bash ./show_config.sh
elif [[ ${SCRIPT} == "Pull all repos" ]]; then
    bash ./puller.sh
elif [[ ${SCRIPT} == "Clone all repos" ]]; then
    bash ./kamino.sh
fi
