# dotfiles

My personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/)

## Usage

Download the repo:

```bash
git clone https://github.com/yourname/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Then for each dotfile directory, run `stow` to apply it. For example, to apply the config for `git`, run:

```bash
stow git
```
