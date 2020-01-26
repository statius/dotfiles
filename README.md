# dotfiles

Proper hacker config for modern macOS and (GNU)Linux

**Code:** [github.com/statius/dotfiles](https://github.com/statius/dotfiles)

## Installation

### Git and the installation script

To clone the repository, run

```shell
git clone https://github.com/statius/dotfiles.git
```

The install script will update all Git submodules and link the files into the appropriate locations (including a symlink to the dotfiles directory as `~/dotfiles`).

```shell
cd dotfiles && ./install
```

The installation script can be run with `--force` (`-f`) to silently overwrite all existing files or with  `--interactive` (`-i`) to ask for comfirmation in each case.

### Specify local settings

I maintain the files below in a separate private repository.

#### `$PATH`

If `~/.path` exists, it will be sourced first, before any other files.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```shell
#!/usr/bin/env sh

export PATH="/usr/local/bin:$PATH"
```

#### Git credentials

Since this is a public repository, I have avoided including my personal Git credentials. If `~/.config/git/config-local` exists, it will be included when `~/.config/git/config` is read. 

My `config-local` file looks something like this:

```properties
[user]

        name = Andrew Miller
        email = amiller@emails
```

#### Wolfram Language `$Path`

If `<$UserBaseDirectory>/Kernel/path.m` exists, it is read during the the Wolfram Language initialization before any other commands are executed. 

#### Local shell settings

If the files `~/.shell_local` (general shell), `~/.bash_local` (Bash-specific), or `~/.zsh_local` (Zsh-specific) exist they will be sourced along with the other files. You can use these to add machine-specific commands or those you don’t want to commit to a public repository.

## Uninstallation

All symlinks can be removed by running the main `uninstall` script, which can called with `--force` (`-f`) to silently unlink or with  `--interactive` (`-i`) to ask for confirmation in each case.

## TODO

- Fix the installation script for macOS Terminal colors.

- Add a customized Zsh prompt.

## Project Information

### Licensing

This project is released under the MIT license.

### Contributions

These dotfiles are maintained by Andrew Miller (and primarily created for my own needs). Feedback is always welcomed.