#!/usr/bin/env expect

##################################################
#              安装 expect
# Ubuntu: sudo apt-get install -y tcl tk expect
# CentOS: sudo yum install -y expect
# MacOS: brew install expect
##################################################

# 设置超时时间 3 秒
set timeout 10

# fork一个子进程执行 ssh
spawn ssh user_name@ip

# 期待匹配到 'user_name@ip_string's password:'
expect "*password*"

# 向命令行输入密码，并回车
send "<password>\r"

# 允许用户与命令行交互
interact
