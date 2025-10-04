" ===================== 基础设置 =====================
set nocompatible              " 关闭 vi 兼容模式
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" ===================== 显示设置 =====================
set number                    " 显示行号
set relativenumber            " 显示相对行号
set showcmd                   " 显示输入命令
set laststatus=2              " 总是显示状态栏
set ruler                     " 显示光标位置
highlight LineNr ctermfg=12 guifg=#4EC9B0

" ===================== 编辑设置 =====================
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set wrap
set linebreak
set scrolloff=5
set backspace=indent,eol,start

" 搜索
set incsearch
set hlsearch
set ignorecase
set smartcase

" jk 映射 ESC
inoremap jk <ESC>
nnoremap jk jk

" 关闭备份/交换/撤销文件
set nobackup
set nowritebackup
set noswapfile
set noundofile

set autowrite
set mouse=a
set history=1000

" ===================== 插件加载 =====================
" Vim 8+ 原生包管理路径
" 插件放在 ~/.vim/pack/plugins/start 下即可自动加载

" 检查 NERDTree 是否存在再映射
if isdirectory(expand("~/.vim/pack/plugins/start/nerdtree"))
    nnoremap <F2> :NERDTreeToggle<CR>
endif

" 检查 lightline 是否存在
if isdirectory(expand("~/.vim/pack/plugins/start/lightline.vim"))
    " 这里可以放 lightline 配置
    let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }
endif

" ===================== 插件路径示例 =====================
" 使用 pack 机制：
" mkdir -p ~/.vim/pack/plugins/start
" cd ~/.vim/pack/plugins/start
" git clone https://github.com/preservim/nerdtree.git
# git clone https://github.com/itchyny/lightline.vim.git
# git clone https://github.com/tpope/vim-surround.git
# git clone https://github.com/tpope/vim-commentary.git

" ===================== 文件类型 =====================
filetype plugin indent on
syntax on
