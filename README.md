# Dot Files

My dotfiles, including:

- [neovim](.config/nvim/README.md) (needs neovim >= v0.10.1)
- kitty
- polybar
- rofi
- glrnvim (GUI neovim wrapper)
- [cosmic](.config/cosmic) (COSMIC DE applets and settings)
- zsh
- prezto conf for my [prezto fork](https://github.com/dcarrillo/prezto)
- p10k

In addition to the dotfiles, some Gnome shell extension confs are included in `dconf/` (GPaste, Hide Top Bar, User Themes) to make polybar and cli great again on Gnome.

## Install

```bash
./config.sh --install          # rsync dotfiles to ~, then load dconf
./config.sh --install-dotfiles # rsync dotfiles only (skip dconf)
./config.sh --install-dconf    # dconf only
./config.sh --dump-dconf       # dump current dconf settings into dconf/
```
