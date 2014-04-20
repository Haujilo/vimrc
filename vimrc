" -----插件配置-------

" 设置pathogen的载入路径，并载入
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" rainbow_parentheses
let g:rbpt_colorpairs = [
      \ ['yellow',       'SeaGreen3'],
      \ ['brown',       'RoyalBlue3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['yellow',         'firebrick3'],
      \ ['brown',       'firebrick3'],
      \ ['darkgray',        'RoyalBlue3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ------------------------------


" 禁用兼容模式
set nocp

" -----主题和颜色相关-------

set t_Co=256
syntax enable

" 设置solarized主题
let g:solarized_termcolors=256
if has('gui_running')
  set background=light
  colorscheme solarized
else
  " 终端下不使用背景，重新定义光标行列与行号列的高亮样式
  let g:solarized_termtrans=1
  set background=dark
  colorscheme solarized
  if version >= 700
    hi CursorLine cterm=bold ctermbg=234 ctermfg=None
    hi CursorColumn cterm=bold ctermbg=234 ctermfg=None
    hi LineNr ctermbg=None ctermfg=175
  endif
endif

set mouse=a
set nu
" 开启光标行着重显示样式
set cursorline
" 开启底部标尺显示
set ruler
" 总是显示状态行
set laststatus=2
" 开启命令菜单提示
set wildmenu
" 设置匹配模式，当属于一个左括号时会匹配相应的那个右括号
set showmatch
" 高亮显示匹配的字符
set hlsearch
" 执行宏、寄存器和其它不通过输入的命令时屏幕不会重画
set lazyredraw

" ------------------------------


" -----内容呈现相关-------

set binary
set encoding=utf8
set fileencodings=utf-8,gb18030,gbk,gb2312,utf-16,big5
" 换行符的格式
set ffs=unix,dos,mac
set textwidth=78
set linebreak
set wrap
set nospell

" ------------------------------


" -----编辑器基础行为-------

autocmd BufRead,BufNewFile *,*.txt setfiletype plaintext
filetype plugin indent on

set history=100
" 搜索不区分大小写，搜索关键字中出现一个大字母时才区分大小写
set ignorecase smartcase
" 动态匹配查找的字符
set incsearch
" 搜索模式特殊字符除了$.*^ 之外其他元字符都要加反斜杠
set magic

" 自动缩进长度
set shiftwidth=2
" 制表符显示长度
set tabstop=2
" 替换制表符为空格
set expandtab
set smarttab
set autoindent
set smartindent

" 纯文本不使用特殊的Tab规则
au FileType plaintext setlocal spell spelllang=en_us sw=8 ts=8 noet nosm noai nosi

" 设置C缩进(http://vimcdoc.sourceforge.net/doc/indent.html#cinoptions-values)
au FileType c,cpp,cs,objc,objcpp,java,php,javascript setlocal noai nosi sw=2 ts=2 cindent

au FileType python setlocal sw=4 ts=4
function InsertPythonHeader()
  " 在打开python的空文件或者新文件的时候，插入头部信息
  let a:_f_size = getfsize(expand("%:p"))
  if a:_f_size == -1 || a:_f_size == 0
    call setline(1, '#! /usr/bin/env python')
    call setline(2, '# -*- coding: utf-8 -*-')
    call setline(3, '')
    call setline(4, 'from __future__ import unicode_literals')
    call setline(5, '')
    call cursor(5, 0)
  endif
endfunction
au FileType python call InsertPythonHeader()

" 保存时删除行尾空白
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWritePre * call DeleteTrailingWS()

" 设置组合键前缀
let g:mapleader=","

" ------------------------------


" -----自定义键映射-------

" 在遇到没有权限写入的文件时，此命令调用sudo写入
noremap <leader>s :w !sudo tee %<CR>

" 插入时间
noremap <leader><F5> "=strftime("%H:%M %Y/%m/%d %A")<CR>gP
inoremap <leader><F5> <C-R>=strftime("%H:%M %Y/%m/%d %A")<CR>

" 映射复制、粘贴和剪切系统黏贴板的快捷键
noremap <leader>c "+y
noremap <leader>x "+d
noremap <leader>v <Esc>:set paste<CR><Esc>"+p<Esc>:set nopaste<CR><Esc>
inoremap <leader>v <Esc>:set paste<CR><ESC>"+p<ESC>:set nopaste<CR><ESC>a

" 映射标签切换快捷键
map <Leader>w <Esc>:tabnew<Space>
imap <Leader>w <Esc>:tabnew<Space>
map <Leader>n <Esc>:tabnext<CR>
imap <Leader>n <Esc>:tabnext<CR>

" ------------------------------
