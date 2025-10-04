#!/bin/zsh

# 用数组存命令和参数，避免空格问题
GIT_CMD=(/usr/bin/git --git-dir="$HOME/.cfg" --work-tree="$HOME")

echo "请输入提交信息（按回车使用默认信息）："
read COMMIT_MESSAGE

if [ -z "$COMMIT_MESSAGE" ]; then
    COMMIT_MESSAGE="auto_message:update dotfiles"
    echo "使用默认提交信息: $COMMIT_MESSAGE"
fi

CHANGES=$("${GIT_CMD[@]}" status --porcelain)

if [ -n "$CHANGES" ]; then
    echo "发现更改，文件列表如下："
    echo "$CHANGES"

    echo "是否添加所有更改的文件？(y/n)"
    read CONFIRM

    if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
        "${GIT_CMD[@]}" add -A
        echo "提交更改..."
        if ! "${GIT_CMD[@]}" commit -m "$COMMIT_MESSAGE"; then
            echo "提交失败，请检查问题。"
            exit 1
        fi
        echo "推送到远程仓库..."
        if ! "${GIT_CMD[@]}" push; then
            echo "推送失败，请检查远程仓库配置或冲突。"
            exit 1
        fi
        echo "操作完成！"
    else
        echo "已取消添加文件，操作终止。"
    fi
else
    echo "没有发现任何更改，无需操作。"
fi
