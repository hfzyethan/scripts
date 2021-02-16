#!/usr/bin/env expect

##########################################################
# 1. Install expect
# Ubuntu: sudo apt-get install -y tcl tk expect
# CentOS: sudo yum install -y expect
# MacOS: brew install expect
# 
# 2. Usage
# 修改user_name、ip、password为对应服务器的用户名、ip和密码
##########################################################

# 设置超时时间 3 秒
set timeout 10

# fork一个子进程执行 ssh
spawn ssh user_name@ip_string

# 期待匹配到 'user_name@ip_string's password:'
expect "*password*"

# 向命令行输入密码，并回车
send "password\r"

# 允许用户与命令行交互
interact
