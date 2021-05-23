#!/usr/bin/env bash

set -e

cask_app_list=(
    # google-chrome      # Chrome浏览器
    firefox # 火狐浏览器国际版
    microsoft-edge     # 微软Edge浏览器
    docker             # Docker客户端（非engine）
    iterm2             # 终端工具
    jetbrains-toolbox  # JetBrains管理工具
    qq                 # QQ
    wechat             # 微信
    youdaodict         # 有道词典
    # youdaonote         # 有道云笔记
    xmind              # 思维导图
    visual-studio-code # VSCode编辑器
    postman            # API测试工具
    cheatsheet         # 应用快捷键提示
    neteasemusic       # 网易云音乐
    yinxiangbiji # 印象笔记（非国际版，国际版是evernote）
    baidunetdisk # 百度网盘
    # sequel-pro # 数据库管理软件（MySQL）
    iina # 音视频播放
    # vlc # vlc播放器
    hiddenbar # 状态栏隐藏工具
    another-redis-desktop-manager # redis可视化客户端
    anaconda    # Python科学计算工具包
    # miniconda   # Python科学计算工具包
    tencent-lemon # 腾讯柠檬清理
    zulu8 # zulu jdk 8（支持Apple Silicon CPU）
    # pdfelement  # 万兴PDF专家
    sogouinput # 搜狗输入法，需要手动open安装
)

cask_work_app_list=(
    # tencent-meeting # 腾讯会议
    # wechatwork # 企业微信
    # sourcetree # git GUI工具
    # dingtalk # 钉钉
    # openvpn-connect # openvpn客户端
)

cli_app_list=(
    tmux # 终端复用工具
    go # Golang
    hugo # 静态页面生成
    tig  # Git查看
    tree # 文件结构查看，中文乱码加-N选项，建议加alias
)


install_cli_app() {
    for app in ${cli_app_list[*]}; do
        brew install "${app}"
    done
}

install_cask_app() {
    for app in ${cask_app_list[*]}; do
        brew install --cask "${app}"
    done
}

install_cask_work_app() {
    for app in ${cask_work_app_list[*]}; do
        brew install --cask "${app}"
    done
}


# 安装CLI软件
install_cli_app


# 安装GUI软件
install_cask_app
