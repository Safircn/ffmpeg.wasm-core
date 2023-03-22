#!/bin/bash

cmds=()

# Detect what dependencies are missing.
for cmd in autoconf automake libtool pkg-config ragel
do
  if ! command -v $cmd &> /dev/null
  then
    cmds+=("$cmd")
  fi
done

# Install missing dependencies
if [ ${#cmds[@]} -ne 0 ];
then
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "" > /etc/apt/sources.list  \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list  \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list  \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list  \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list \
    && apt update
    apt-get install -y ${cmds[@]}
  else
    brew install ${cmds[@]}
  fi
fi
