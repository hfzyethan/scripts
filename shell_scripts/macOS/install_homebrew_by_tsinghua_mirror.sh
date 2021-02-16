#!/usr/bin/env bash

# 0. 安装依赖，git, curl等
# xcode-select --install

# 1. 导入环境变量
HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# 2. 下载安装脚本，替换地址
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install

# 2.1 替换下载源安装
/bin/bash -c "$(sed 's|^HOMEBREW_BREW_GIT_REMOTE=.*$|HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"|g' brew-install/install.sh)"

# 2.2 删除安装脚本
rm -rf brew-install

# 3. 加入PATH
UNAME_MACHINE="$(uname -m)"

# Apple Silicon CPU
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    grep -qF '/opt/homebrew/bin' /etc/paths || sudo sed -i "" '1i /opt/homebrew/bin' /etc/paths
    grep -qF '/opt/homebrew/share/man' /etc/manpaths || sudo sed -i "" '1i /opt/homebrew/share/man' /etc/manpaths
fi

# 4. 替换上游
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
BREW_TAPS="$(brew tap)"
for tap in core cask{,-fonts,-drivers,-versions}; do
    if echo "$BREW_TAPS" | grep -qE "^homebrew/${tap}\$"; then
        # 将已有 tap 的上游设置为本镜像并设置 auto update
        # 注：原 auto update 只针对托管在 GitHub 上的上游有效
        git -C "$(brew --repo homebrew/${tap})" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git
        git -C "$(brew --repo homebrew/${tap})" config homebrew.forceautoupdate true
    else   # 在 tap 缺失时自动安装（如不需要请删除此行和下面一行）
        brew tap --force-auto-update homebrew/${tap} https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git
    fi
done

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
