# Run script for gtls

#! /bin/bash

if  [[ uname == "Darwin" ]]; then
    PKG_MANAGER="brew"
elif [[ uname == "Linux" ]]; then
    PKG_MANAGER="sudo apt-get"
else
    echo "Unrecognised OS: ${uname}. Exiting."
    exit 1
fi

if ! command -v $PKG_MANAGER &> /dev/null; then
    echo "${PKG_MANAGER} not found. Exiting."
    exit 1
fi

$PKG_MANAGER update
$PKG_MANAGER upgrade

if ! command -v git &> /dev/null; then
    $PKG_MANAGER install git
elif ! command -v gum &> /dev/null; then
    $PKG_MANAGER install gum
elif ! command -v curl &> /dev/null; then
    $PKG_MANAGER install curl
elif ! command -v jq &> /dev/null; then
    $PKG_MANAGER install jq
fi

for script in ${pwd}/*; do
    chmod +x $script
done

SCRIPT=$(gum choose --height 15 {"Show config", "Pull all repos", "Clone all repos"})

if [[ ${SCRIPT} == "Show Config" ]]; then
    bash ./show_config.sh
elif [[ ${SCRIPT} == "Pull all repos" ]]; then
    bash ./puller.sh
elif [[ ${SCRIPT} == "Clone all repos" ]]; then
    bash ./kamino.sh
fi
