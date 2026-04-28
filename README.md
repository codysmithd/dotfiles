# Cody's Dotfiles

This repository contains my personal `zsh` configuration.

## Installation

The included script automates the entire process, and is idempotent.

1.  **Clone the repository:**
    ```shell
    git clone https://github.com/codysmithd/dotfiles.git ~/.codysmithd-dotfiles
    ```

2.  **Run the installer:**
    ```shell
    ./install.sh
    ```

## Submodules

Contains the following submodules in `third_party/` to be batteries-included:

*   [Powerlevel10k](https://github.com/romkatv/powerlevel10k): A fast and flexible theme.
*   [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): Provides command-line syntax highlighting.
*   [zsh-defer](https://github.com/romkatv/zsh-defer): Defers plugin initialization to speed up shell startup.
