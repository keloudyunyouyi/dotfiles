" 基础设置
set nocompatible              " 关闭vi兼容模式
filetype off                  " 关闭文件类型检测（插件管理需要）
set encoding=utf-8            " 设置编码
set termencoding=utf-8
set fileencoding=utf-8

" 显示设置
set number                    " 显示行号
set relativenumber            " 显示相对行号
set cursorline                " 高亮当前行
set showcmd                   " 显示输入的命令
set laststatus=2              " 总是显示状态栏
set ruler                     " 显示光标位置

" 编辑设置
set autoindent                " 自动缩进
set smartindent               " 智能缩进
set tabstop=4                 " Tab宽度
set shiftwidth=4              " 自动缩进宽度
set expandtab                 " 将Tab转换为空格
set wrap                      " 自动换行
set linebreak                 " 按单词换行
set scrolloff=5               " 光标上下保留5行
set backspace=indent,eol,start " 允许退格键删除

" 搜索设置
set incsearch                 " 实时搜索
set hlsearch                  " 搜索结果高亮
set ignorecase                " 忽略大小写
set smartcase                 " 大写字母时区分大小写

" jk映射为ESC，快速退出插入模式
inoremap jk <ESC>
nnoremap jk jk

" 关闭备份、交换和撤销文件功能 - 新增设置
set nobackup                  " 关闭备份文件
set nowritebackup             " 不创建临时备份文件
set noswapfile                " 关闭交换文件
set noundofile                " 关闭撤销文件

" 其他设置
set autowrite                 " 自动保存
set mouse=a                   " 启用鼠标支持
set history=1000              " 命令历史记录数量

" 插件管理 - Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'  " Vundle本身

" 实用插件
Plugin 'tpope/vim-surround'    " 处理括号、引号等包围结构
Plugin 'tpope/vim-commentary'  " 快速注释代码
Plugin 'preservim/nerdtree'    " 文件浏览器
Plugin 'itchyny/lightline.vim' " 美化状态栏

call vundle#end()
filetype plugin indent on     " 启用文件类型检测

" 插件配置
" NERDTree配置
map <F2> :NERDTreeToggle<CR>  " F2键开关文件浏览器
