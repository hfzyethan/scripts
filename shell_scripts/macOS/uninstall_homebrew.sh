#!/usr/bin/env bash

# 1. 下载安装脚本，替换地址
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install

# 1.1 替换下载源
/bin/bash -c "$(sed 's|^HOMEBREW_BREW_GIT_REMOTE=.*$|HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"|g' brew-install/uninstall.sh)"

# 1.2 删除安装脚本
rm -rf brew-install

