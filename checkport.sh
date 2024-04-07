#!/bin/bash

# 获取当前正在监听5244端口的应用程序信息
listening_apps=$(netstat -tuln | grep 5244 | grep -v "LISTEN")

# 判断是否有应用程序在监听5244端口
if [ -z "$listening_apps" ]; then
    echo "没有应用程序正在监听5244端口。"
else
    echo "以下应用程序正在监听5244端口："
    echo "$listening_apps"
fi
