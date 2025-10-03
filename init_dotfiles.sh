#!/bin/zsh

# 配置文件存储目录（假设已克隆到该位置）
DOTFILES_DIR="$HOME/.cfg"
BACKUP_DIR="$HOME/.config-backup"

# 检查裸仓库是否已存在
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "错误: 未找到Dotfiles仓库，请先克隆仓库到 $DOTFILES_DIR"
    echo "克隆命令示例: git clone --bare <你的仓库地址> $DOTFILES_DIR"
    exit 1
fi

# 创建备份目录
echo "创建配置备份文件夹..."
mkdir -p "$BACKUP_DIR"

# 设置临时别名
echo "配置临时config别名..."
alias config='/usr/bin/git --git-dir='$DOTFILES_DIR' --work-tree='$HOME''

# 处理冲突文件
echo "处理可能的冲突文件..."
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} "$BACKUP_DIR"/{} 2>/dev/null

# 重新检出配置文件
echo "检出配置文件..."
config checkout

# 配置只显示已跟踪文件
echo "配置显示选项..."
config config --local status.showUntrackedFiles no

echo "Dotfiles配置完成！"
echo "当前终端可使用 'config' 命令管理Dotfiles"
echo "若需在新终端使用，请执行: alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'"

