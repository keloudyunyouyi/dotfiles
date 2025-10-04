#!/bin/zsh
# install-dotfiles.sh
# 一步安装 dotfiles 仓库并执行仓库里的 setup 脚本

# --- 配置 ---
DOTFILES_REPO="https://github.com/keloudyunyouyi/dotfiles"
GIT_DIR="$HOME/.cfg"
BACKUP_DIR="$HOME/.config-backup"
# ----------------

echo "1. 克隆裸仓库..."
if [ -d "$GIT_DIR" ]; then
    echo "$GIT_DIR 已存在，跳过克隆"
else
    git clone --bare "$DOTFILES_REPO" "$GIT_DIR"
fi

# 临时 alias
alias config='/usr/bin/git --git-dir=$GIT_DIR --work-tree=$HOME'

# 创建备份目录
mkdir -p "$BACKUP_DIR"

echo "2. 检出配置文件（冲突文件将备份）..."
conflicts=$(config checkout 2>&1 | egrep "\s+\." | awk '{print $1}')
if [ -n "$conflicts" ]; then
    echo "发现冲突文件，备份到 $BACKUP_DIR ..."
    for file in $conflicts; do
        mkdir -p "$(dirname "$BACKUP_DIR/$file")"
        mv "$HOME/$file" "$BACKUP_DIR/$file"
    done
fi

# 再次检出
config checkout
config config --local status.showUntrackedFiles no

# 检查仓库里是否有 setup.sh
if [ -f "$HOME/setup.sh" ]; then
    echo "3. 运行仓库里的 setup.sh ..."
    bash "$HOME/setup.sh"
else
    echo "仓库里没有 setup.sh，安装完成 ✅"
fi
