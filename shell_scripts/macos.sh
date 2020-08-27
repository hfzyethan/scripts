
#!/bin/bash

set -u


cask_app_list=(
  google-chrome # Chrome浏览器
  microsoft-edge # 微软Edge浏览器
  docker # Docker客户端（非engine）
  iterm2 # 终端工具
  jetbrains-toolbox # JetBrains管理工具
  qq # QQ
  wechat # 微信
  youdaodict # 有道词典
  xmind # 思维导图
  visual-studio-code # VSCode编辑器
  postman # API测试工具
  cheatsheet # 应用快捷键提示
  neteasemusic # 网易云音乐
  yinxiangbiji # 印象笔记（非国际版，国际版是evernote）
  baidunetdisk # 百度网盘
  sequel-pro # 数据库管理软件（MySQL）
  iina # 视频播放
)


cask_work_app_list=(
  tencent-lemon # 腾讯柠檬清理
  tencent-meeting # 腾讯会议
  wechatwork # 企业微信
  sourcetree # git GUI工具
  dingtalk # 钉钉
  openvpn-connect # openvpn客户端
)


cli_app_list=(
  tmux # 终端复用工具
  go # Golang
  hugo # 静态页面生成
  tig # Git查看
  tree # 文件结构查看
)


install_cask_app() {
  for app in ${cask_app_list[*]}; do
    brew cask install "${app}"
  done
}


install_cask_work_app() {
  for app in ${cask_work_app_list[*]}; do
    brew cask install "${app}"
  done
}


install_cli_app() {
  for app in ${cli_app_list[*]}; do
    brew install "${app}"
  done
}


# 安装CLI软件
install_cli_app


# 安装GUI软件
install_cask_app

