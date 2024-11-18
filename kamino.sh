# Mass cloner from GitHub. Places cloned repositories
# in a couple of directories depending on whether they
# are public, private or forks.

#! /bin/bash

read -p "What's your GitHub username? " user

mkdir -p ~/Projects/Public 
mkdir -p ~/Projects/Private 
mkdir -p ~/Projects/Forks
mkdir -p ~/Projects/Archive

if ! command gh &> /dev/null; then
    echo "GitHub CLI is not installed"
    exit 1
fi

printf "\nAuthenticating with GitHub. Please follow prompts\n"

gh auth login



cd ~/Projects/Forks
printf "\nCloning Forks\n"

gh repo list $user --fork | while read -r repo _; do
    printf "\nCloning $repo (Fork)\n"
    gh repo clone "$repo" "$repo"
done

cd ~/Projects/Private
printf "\nCloning Private Repos\n"

gh repo list $user --visibility "private" --no-archived | while read -r repo _; do
    printf "\nCloning $repo (Private)\n"
    gh repo clone "$repo" "$repo"

done

cd ~/Projects/Archive
printf "\nCloning Archived Repos\n"

gh repo list $user --archived | while read -r repo _; do
    printf "\nCloning $repo (Archive)\n"
    gh repo clone "$repo" "$repo"
done

cd ~/Projects/Public
printf "\nCloning Public Repos\n"

gh repo list $user --visibility "public" --no-archived --source| while read -r repo _; do
    printf "\nClone $repo (Public)\n"
    gh repo clone "$repo" "$repo"
done

printf "\nAll cloned!\null"
