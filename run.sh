# Run script for gtls

#! /bin/bash

if  [[ $(uname) == "Darwin" ]]; then
    PKG_MANAGER="brew"
elif [[ $(uname) == "Linux" ]]; then
    PKG_MANAGER="sudo apt-get"
else
    echo "Unrecognised OS: ${uname}. Exiting."
    exit 1
fi

if ! command -v $PKG_MANAGER &> /dev/null; then
    echo "${PKG_MANAGER} not found. Exiting."
    exit 1
fi


echo "Running on $(uname) with ${PKG_MANAGER}"


echo "Updating packages with ${PKG_MANAGER}"
$PKG_MANAGER update
$PKG_MANAGER upgrade

if ! command -v git &> /dev/null; then
    echo "Git not found. Installing."
    $PKG_MANAGER install git
elif ! command -v gum &> /dev/null; then
    echo "Gum not found. Installing."
    $PKG_MANAGER install gum
elif ! command -v curl &> /dev/null; then
    echo "curl not found. Installing."
    $PKG_MANAGER install curl
elif ! command -v jq &> /dev/null; then
    echo "jq not found. Installing."
    $PKG_MANAGER install jq
fi

for script in ${pwd}/*; do
    chmod +x $script
done

SCRIPT=$(gum choose --height 15 "Show config" "Pull all repos" "Clone all repos")

echo ${SCRIPT}

if [[ ${SCRIPT} == "Show config" ]]; then
    bash ./show_config.sh
elif [[ ${SCRIPT} == "Pull all repos" ]]; then
    bash ./puller.sh
elif [[ ${SCRIPT} == "Clone all repos" ]]; then
    bash ./kamino.sh
fi
