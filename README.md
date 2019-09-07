# dotfiles

Proper hacker defaults for modern macOS and (GNU)Linux

**Code:** [github.com/statius/dotfiles](https://github.com/statius/dotfiles)

## Installation

### Git and the installation script

You can clone the repository wherever you want. The Wolfram Language package `CustomTicks` is included as a submodule, so it must be initialized (hence, `--recurse-submodules`):

```shell
git clone https://github.com/statius/dotfiles.git --recurse-submodules
```

The install script will link the files into the appropriate locations (including a symlink to the dotfiles directory as `~/dotfiles`).

```bash
cd dotfiles && ./install.sh
```

The installation script can be run with `--force` (`-f`) to silently overwrite all existing files or with  `--interactive` (`-i`) to ask for comfirmation in each case.

### Specify local settings

#### `$PATH`

If `~/.path` exists, it will be sourced first, before any other files.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```shell
export PATH="/usr/local/bin:$PATH"
```

#### Git credentials

Since this is a public repository, I have avoided including my personal Git credentials. If `~/.gitconfig-local` exists, it will be included when `~/.gitconfig` is read. 

My `~/.gitconfig-local` looks something like this:

```properties
[user]

        name = Andrew Miller
        email = amiller@emails
```

#### Wolfram Language `$Path`

If `<$UserBaseDirectory>/Kernel/path.m` exists, it is read during the the Wolfram Language initialization before any other commands are executed. 

#### Local shell settings

If the files `~/.shell_local` (general shell) and `~/.bash_local` (bash-specific) exist they will be sourced along with the other files. You can use these to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

## Uninstallation

All symlinks can be removed by running the main `uninstall.sh` script, which can called with `--force` (`-f`) to silently unlink or with  `--interactive` (`-i`) to ask for confirmation in each case.

## Project Information

### Licensing

This project is released under the MIT license.

### Contributions

These dotfiles are maintained by Andrew Miller (and primarily created for my own needs). Feedback is always welcomed.

Thanks to [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles).