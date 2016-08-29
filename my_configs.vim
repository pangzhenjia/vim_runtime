 set nu
 set cursorline " 突出显示当前行
 set autochdir " 自动切换当前目录为当前文件所在的目录
 set clipboard+=unnamed
filetype on  " 载入文件类型插件
filetype plugin on  " 为特定文件类型载入相关缩进文件
filetype indent on  " 保存全局变量
set completeopt=longest,menu

let g:ackprg = 'ag --nogroup --nocolor --column' "ag setting

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

:nn <leader>1 1gt
:nn <leader>2 2gt
:nn <leader>3 3gt
:nn <leader>4 4gt
:nn <leader>5 5gt
:nn <leader>6 6gt
:nn <leader>7 7gt
:nn <leader>8 8gt
:nn <leader>9 9gt
:nn <leader>0 :tablast<CR>

set background=light
colorscheme solarized

if version>=6.3
    set helplang=cn
endif


set rtp+=~/.fzf
set tags=~/Desktop/dsa_ex/tags

map <leader>zsh :e ~/.zshrc<cr>

"option setting
map <leader>q :q<cr>
map <leader>dir :tabnew .<cr>
map <leader>vs :vs<cr>

"plugin setting
" FZF
map <leader>fz :FZF<cr>
map <leader>fh :History<cr>
map <leader><leader>f :FZF ~<cr>


"C，C++ 按control-9 编译运行
map <leader>m :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

"C,C++的调试
map <leader>d :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc



