##############################################################################
#                           Oh My Zsh 核心配置                               #
##############################################################################

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
source $ZSH/oh-my-zsh.sh

##############################################################################
#                           插件自动安装逻辑                                  #
##############################################################################

# 插件安装目录（Oh My Zsh 自定义插件默认路径）
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# 定义需要安装的插件（与上方 plugins 列表对应）
declare -A plugins_to_install=(
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"  # 命令补全增强
)

# 自动安装缺失的插件
for plugin in "${(@k)plugins_to_install}"; do
  plugin_dir="$ZSH_CUSTOM/plugins/$plugin"
  if [ ! -d "$plugin_dir" ]; then
    echo "安装插件: $plugin..."
    git clone --depth=1 "${plugins_to_install[$plugin]}" "$plugin_dir"
  fi
done

##############################################################################
#                           系统环境配置                                     #
##############################################################################

# 语言环境
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

# fnm
FNM_PATH="/home/keloud/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
# go 环境
export PATH=$PATH:/usr/local/go/bin

##############################################################################
#                           终端交互与显示                                   #
##############################################################################

# 欢迎信息
figlet "HI LIN"

# 历史命令时间戳格式
HIST_STAMPS="yyyy-mm-dd"


##############################################################################
#                           Zsh 行为设置                                     #
##############################################################################

# 禁用通配符扩展
setopt NO_NOMATCH

# 启用 Oh My Zsh 自动更新
zstyle ':omz:update' mode auto


##############################################################################
#                           自定义别名配置                                   #
##############################################################################

# Dotfiles 管理命令
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  EDITOR=micro yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
