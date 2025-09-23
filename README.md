# Cody's Personal ZSH Configuration

This repository houses my personal ZSH shell configuration, designed to be a robust and pleasant base for any Unix-like system. It's structured to be easily included in other dotfile setups (like my work machine) or used standalone.

## Features

*   **Sensible Defaults:** Includes a range of options for history management, completions, and interactive use.
*   **Plugin Ready:** Comes pre-configured with some of the most useful ZSH plugins:
    *   [Powerlevel10k](https://github.com/romkatv/powerlevel10k): A fast and flexible theme.
    *   [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): Provides syntax highlighting for commands in the terminal.
    *   [zsh-defer](https://github.com/romkatv/zsh-defer): Allows deferring the initialization of ZSH plugins to speed up shell startup.
*   **Organized Structure:** Settings are split into logical files within `.zshrc.d/`.
*   **Stow Compatible:** Designed to be managed and deployed using [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

1.  **Clone the repository:**
    ```shell
    git clone https://github.com/codysmithd/dotfiles.git ~/.dotfiles-personal
    ```

2.  **Initialize Submodules:**
    ```shell
    cd ~/.dotfiles-personal
    git submodule update --init --recursive
    ```

3.  **Stow the configuration:**
    Make sure you don't have an existing `~/.zshrc` or `~/.zshrc.d` that would conflict, or back them up.
    ```shell
    stow -t ~ .
    ```

4.  **Reload your shell:**
    ```shell
    exec zsh
    ```

## Structure

*   `.zshrc`: The main ZSH runtime configuration file, loaded by your shell.
*   `.zshrc.d/`: Contains various configuration snippets for organization.
    *   `completion.zsh`: Completion system tweaks.
    *   `history.zsh`: History settings.
    *   `.p10k.zsh`: Powerlevel10k configuration.
*   `third_party/`: Git submodules for external plugins.
*   `.gitmodules`: Defines the submodules.
*   `.stow-ignore`: Tells stow what to ignore.
