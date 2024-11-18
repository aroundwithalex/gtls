# Adds SSH keys to a GitHub account and tests

printf "\nAdding SSH keys to GitHub\n"

read -p "What's your email address? " email

ssh-keygen -t ed25519 -C "$email"

eval "$(ssh-agent -s)"

read -p "What's the path to your SSH key? " key_path

# These lines for specific for macOS
ssh_file=~/.ssh/config

if [ $(uname) == 'Darwin' ]; then

    if [ ! -f $ssh_file ]; then
        touch ~/.ssh/config
    fi

    ssh_contents="  
        Host github.com
          AddKeysToAgent yes
          UseKeychain yes
          IdentityFile ${key_path}
    "

    echo $ssh_contents >> $ssh_file
    printf "\nUpdated SSH config with new SSH key\n"

    ssh-add --apple-use-keychain $key_path
elif [ $(uname) == 'Linux' ]; then
    ssh-add $key_path
fi

if ! command -v gh &> /dev/null; then
    printf "\ngh CLI not installed. Please add key manually\n"
    exit 1
fi

read -p "What should the SSH key be called? " key_title

gh ssh-key add "${key_path}.pub" --title "$key_title"

printf "\nAdded new SSH key to GitHub\n"

