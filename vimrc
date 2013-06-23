source ~/.vim/bundles.vim

filetype plugin indent on

"{{{ General
set nocompatible            " 关闭兼容模式
set history=500             " 命令显示历史
set modelines=0

let g:mapleader = ","       " 全局设置用,代替\

set background=dark
set t_Co=256                " 设置vim模式为256色
colorscheme molokai

set scrolloff=3             "上下滚动隔3行

set backspace=indent,eol,start " 退格键和方向键可以换行
set whichwrap+=<,>,h,l

set nu                      " 显示行号
set showcmd                 " 显示未完成的命令

set ignorecase              " 搜索时忽略大小写
set smartcase               " 如果搜索模式包含大写字符，
                            "   不使用 'ignorecase' 选项
set gdefault
set hlsearch                " 开启高亮显示结果
set wrapscan                " 搜索到文件两端时重新搜索
set incsearch               " 开启实时搜索功能
map <silent> <leader><cr> :noh<cr>

set showmatch               " 显示括号配对情况
set matchtime=1             " 跳转到匹配括号的时间

set magic                   " 增强行正则

set cpoptions+=$            " cw显示$
set wrap                    " 自动换行
set textwidth=79
set formatoptions+=mM
"set colorcolumn=80

set laststatus=2            " 开启状态栏信息
set cmdheight=1             " 命令行的高度，默认为1
set ruler                   " 右下角显示光标位置的状态行

set vb t_vb=                " 关闭提示音
set novisualbell
set hidden                  " 允许在有未保存的修改时切换缓冲区

set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoindent              " 继承前一行的缩进方式
set cindent                 " c/c++样式缩进
set smartindent             " 为c/c++程序提供自动缩进

syntax enable               " 打开语法高亮
syntax on                   " 开启文件类型侦测

set nobackup                " 设置无备份文件
set nowritebackup
setlocal noswapfile         " 不生成swap文件
set autoread                " 当文件在外部被修改时，自动重新读取

set completeopt=longest,menu    " 关掉智能补全时的预览窗口
set wildmenu                    " 命令补全
"set wildmode=longest,list,full " tab键显示文件列表

set path+=../include
set tags=tags,~/.systags;
"set autochdir                      " 当前目录为工作目录

set dictionary+=~/.vim/dict/simple  " For i_CTRL_X_K
"set iskeyword+=_,$,@,%,#,-

"set foldenable             " 开始折叠
"set foldmethod=syntax      " 设置语法折叠
"set foldcolumn=0           " 设置折叠区域的宽度
"setlocal foldlevel=1       " 设置折叠层数为
"set foldclose=all          " 设置为自动关闭折叠
"set fo=croq                " c格式化代码
"au BufWinLeave * silent! mkview "make vim save view (state) (folds, cursor, etc)
"au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc))

"set list                   " 显示Tab符，使用一高亮竖线代替
" set listchars=tab:>-,trail:-

"set shortmess=atI          " 不显启动时的信息
"set cursorline             " 突出显示当前行
iab frm from
set fillchars="|"           "在被分割的窗口间不显示

if v:version > 702
    set undofile
    set undodir=$HOME/.undodir
    set undolevels=1000
endif

"记得上次退出时的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

if has("gui_running")
    if has("win32") || has("win64")
        "激活菜单栏
        noremap <M-Space> :simalt ~<CR> 
        inoremap <M-Space> <C-O>:simalt ~<CR>
        cnoremap <M-Space> <C-C>:simalt ~<CR>
        set guifont=Courier\ New:h12
        au GUIEnter * simalt ~x			" 窗口启动时自动最大化
    else
        set guifont=Courier\ 10\ Pitch\ 12
    endif

    "解决菜单栏乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    set guioptions-=m				" 隐藏菜单栏
    set guioptions-=T				" 隐藏工具栏
    set guioptions-=L				" 隐藏左侧滚动条
    set guioptions-=r				" 隐藏右侧滚动条
    set guioptions-=b				" 隐藏底部滚动条
    set showtabline=0				" 隐藏Tab栏
    set cursorline
    hi cursorline guibg=#333333
endif
"}}}

"{{{ Shortcuts
" Quit quickly
map <leader>f :q!<CR>
map <leader>z :x<CR>
cmap w!! %!sudo tee > /dev/null %

" Quick escape
imap jj <ESC>
imap JJ <ESC>

" Read binary
map <leader>rb :%!xxd<CR>
map <leader>rnb :%!xxd -r<CR>

" tab
map <Tab> :bn<CR>
map <s-Tab> :bp<CR>
map <leader>bd :bd<CR>

" format the entire file
"autocmd BufWritePost *.c normal mzgg=G`z
nmap <leader>fef ggVG=``
nnoremap <leader>q gqip 

" 开启关闭粘贴
map <leader>pp :setlocal paste!<CR>

" 开启关闭拼写检查
map <leader>ss :setlocal spell!<CR>

" Some helpers to edit mode
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>

" bash map
nmap <silent> <leader>cd :lcd %:h<CR>
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

nmap<leader>m :wa<CR>:make<CR>:cw<CR><CR>

map <leader>ax :!chmod a+x %<CR><CR>

nmap <C-k> :!sdcv <C-R>=expand("<cword>")<CR><CR>

map <leader>k :!qref <cword><ENTER>

" Disable the arrow keys 
nnoremap <UP> <Nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Treat long lines as break lines (useful when moving around in them),
" conflict snipmate
" nnoremap j gj
" nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l
" inoremap <C-h> <Esc><C-W>h
" inoremap <C-j> <Esc><C-W>j
" inoremap <C-k> <Esc><C-W>k
" inoremap <C-l> <Esc><C-W>l
nnoremap ; :
vnoremap ; :
"}}}

"{{{ Encode
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termencoding=utf-8
"}}}

"{{{ TAB键的自动完成现在会忽略这些文件
set wildignore+=*.luac              " Lua byte code
set wildignore+=*.pyc               " Python byte code
set wildignore+=*.spl               " compiled spelling word lists
set wildignore+=*.sw?               " Vim swap files
set wildignore+=*.aux,*.out,*.toc   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
"}}}

"{{{ note-taking
"if has("autocmd")
    "autocmd bufwritepost .vimrc source $MYVIMRC
"endif
"nmap <leader>ee :tabedit $MYVIMRC<CR>

autocmd FileType help set ma
autocmd FileType help set noreadonly
"autocmd BufWritePost ~/.vim/doc/*:helptags ~/.vim/doc
"}}}

"{{{ ctrlp.vim
let g:ctrlp_map = ',,'
let g:ctrlp_open_multiple_files = 'v'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg)$',
  \ }
"}}}

"{{{ neocomplcache.vim
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"}}}

"{{{ tabular.vim
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Space> :Tabularize / /<CR>
vmap <Leader>a<Space> :Tabularize / /<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
"}}}

"{{{ delimitmate.vim
au FileType * let b:delimitMate_autoclose = 1

" If using html auto complete (complete closing tag)
au FileType xml,html,xhtml let b:delimitMate_matchpairs ="(:),[:],{:}"
"}}}

"{{{ nerdcommenter.vim
"[count],cc 光标以下count行逐行添加注释(7,cc)
"" [count],cu 光标以下count行逐行取消注释(7,cu)
"" [count],cm 光标以下count行尝试添加块注释(7,cm)
"" ,cA 在行尾插入 /* */,并且进入插入模式。 这个命令方便写注释。

" 空格键添加去除注释
"map <space> <leader>ci
"map <space> <plug>NERDCommenterInvert
"let NERDCreateDefaultMappings=0

let NERDSpaceDelims=1       " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1   " 多行注释时样子更好看
"}}}

"{{{ tagbar.vim
nmap <silent> ,t :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 36

" nmap <leader>g :!ctags --language-force=c *.c ../include/*.h<CR>
nmap <leader>g :!ctags -R --language-force=c++<CR>

function Updatetags()
    if &filetype == 'c'
        exec "!ctags --language-force=c *.c ../include/*.h"
    else
        exec "!ctags -R --language-force=c++"
    endif
endfunction

nmap <leader>g :call Updatetags() <CR>

"}}}

"{{{ DoxygenToolkit.vim
" highlight the doxygen comments
let g:load_doxygen_syntax=1
set syntax=cpp.doxygen

let g:DoxygenToolkit_authorName="xutao butbueatiful@gmail.com"
let g:DoxygenToolkit_versionString="1.0"
let s:licenseTag = "Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1

nmap dx :Dox<CR>
nmap da :DoxAut<CR>
nmap dl :DoxLic<CR>

autocmd BufNewFile *.{h,hpp,c,cpp} DoxAuthor
"}}}

"{{{ NERDTree.vim
":ERDtree 打开NERD_tree :NERDtreeClose    关闭NERD_tree  
"o 打开关闭文件或者目录 t 在标签页中打开  
"T 在后台标签页中打开   ! 执行此文件  
"p 到上层目录           P 到根目录  
"K 到第一个节点         J 到最后一个节点  
"u 打开上层目录         m 显示文件系统菜单（添加、删除、移动操作）  
"r 递归刷新当前目录     R 递归刷新当前根目录  
nmap ,n :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1
let NERDTreeWinpos="left"
let NERDTreeQuitOnOpen=1            " 打开文件后, 关闭NERDTrre窗口
let NERDTreeWinSize=31              " 设置窗口大小
"let NERDTreeHighlightCursorline=1  " 高亮NERDTrre窗口的当前行
"}}}

"{{{ vim-markdown.vim
let g:vim_markdown_folding_disabled=1
"}}}

"{{{ Fugitive.vim
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
"}}}

"{{{ QuickFix Window, which is borrowed from c9s
command -bang -nargs=? QFix call QFixToggle(<bang>0)

function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win=bufnr("$")
  endif
endfunction

nnoremap <leader>qx :QFix<CR>
autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
"}}}

"{{{ vim-powerline.vim
let g:Powerline_symbols='unicode'
"}}}

"{{{ man.vim
source $VIMRUNTIME/ftplugin/man.vim
nnoremap <silent> <S-k> :Man <c-r>=expand("<cword>")<CR><CR>
"}}}
