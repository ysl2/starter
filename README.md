# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

```bash
sudo apt install -y xsel
brew install rustup; rustup toolchain install nightly

# Ref: https://github.com/zegervdv/homebrew-zathura?tab=readme-ov-file#osx_native_integration
brew install girara --HEAD
brew install zathura --HEAD
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib

# https://ghproxy.link

`custom = true`: This means that the plugin is added by myself.
```
