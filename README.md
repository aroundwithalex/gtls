# gtls: Git Tools

Contains a series of git tools to make various tasks easier. These
include printing configuration data in a relatively nice way and
enabling the mass pulling of repositories.


# How to run

Clone this repository locally and enter into the root directory. You can
run each tool individually, but it is recommended that you use the provided
runner which will ensure that the correct dependencies are installed such as:

- [gum](https://github.com/charmbracelet/gum)
- [gh](https://cli.github.com/)
- [git](https://git-scm.com/)
- [jq](https://jqlang.github.io/jq/)
- [curl](https://curl.se/)

Use `bash run.sh` to launch the run script. It might work with other shell
scripting languages but has only been tested with Bash. The script will detect
which OS you're using and update the relevant packages. It will then present
a menu, allowing you to choose what you'd like to do. The options include:

- Pulling all repositories at a specific path.
- Cloning all repositories for a user.
- Showing the local configuration for Git.
- Add an SSH key to GitHub.
