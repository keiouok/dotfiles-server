""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" DEIN.VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
    set nocompatible
endif

"" install dir
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"" dein installation check
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

"" begin settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " .toml file
    let s:rc_dir = expand('~/.config/nvim')
    if !isdirectory(s:rc_dir)
        call mkdir(s:rc_dir, 'p')
    endif
    let s:toml = s:rc_dir . '/dein.toml'

    " read toml and cache
    call dein#load_toml(s:toml, {'lazy': 0})

    " end settings
    call dein#end()
    call dein#save_state()
endif

" plugin installation check
if dein#check_install()
    call dein#install()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" VIM ENVIRONMENTAL SETTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<Space>"

" autocmds
augroup vimrc
    autocmd!
    autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup END

"" Color settings
syntax enable

let g:my_color = 'dracula'

" Check
"" Spell check
autocmd Colorscheme * hi SpellBad ctermfg=none ctermbg=none cterm=underline

" Tab, Space, etc..
" NonText
    " EOL, extends, precedes
" SpecialKey
    " nbsp, tab, trail
autocmd Colorscheme * hi NonText    ctermbg=None ctermfg=13
autocmd Colorscheme * hi SpecialKey ctermbg=None ctermfg=13 cterm=italic

" Visual mode
autocmd Colorscheme * hi Visual cterm=reverse

" mark
autocmd ColorScheme * hi InterestingWord1 ctermfg=0 ctermbg=47   " みどり
autocmd ColorScheme * hi InterestingWord2 ctermfg=0 ctermbg=45   " 水色

" " cursourline
" autocmd ColorScheme * hi CursorLine term=bold cterm=bold guibg=Grey40
autocmd ColorScheme * hi CursorLine term=bold cterm=bold guibg=dark
autocmd ColorScheme * hi Comment term=bold cterm=bold guibg=dark

" autocmd ColorScheme * hi vimRainbow_lv0_o0 ctermfg=white guifg=white

" Set color scheme
set background=dark
if exists('g:my_color')
    exe('colorscheme ' . g:my_color)
else
    echom 'Error: s:my_color is not exists. (at init.vim)'
endif

" Show space or tab in the last line
" highlight TrailingSpaces ctermbg=red guibg=#FF0000
" highlight TrailingSpaces ctermbg=blue guibg=#FF0000
"46 (green), 240 (gray), 50 (skyblue)
highlight TrailingSpaces ctermbg=50 ctermfg=50 cterm=bold
highlight Tabs ctermbg=black guibg=8 " guibg=#000000
autocmd BufNewFile,BufRead * call matchadd('TrailingSpaces', ' \{-1,}$')
autocmd BufNewFile,BufRead * call matchadd('Tabs', '\t')

" Show byte-space
highlight ZenkakuSpace cterm=underline ctermbg=BLUE
autocmd BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
autocmd WinEnter    * let w:m3 = matchadd("ZenkakuSpace", '　')

" number setting
set nrformats=

" refresh time
set updatetime=100

" encoding
set encoding=utf8
scriptencoding utf8
set fileencoding=utf-8
set termencoding=utf8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
set ambiwidth=double
set nobomb
set t_Co=256

" swap
set noswapfile

" beep sound
set belloff=all

" numer & title
set number
set title

" indent & cursor
set cursorline
set hlsearch
set smartindent
set laststatus=2
set wildmenu
set visualbell
set showmatch
set list listchars=tab:\>\-
set shiftwidth=4 softtabstop=4 expandtab

set nocp
if has("autocmd")
    filetype plugin on
    filetype indent on
    " each abbrebiation is equal to softtabstop, shiftwidth, tabstop, expandtab
    autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
    autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType html       setlocal sw=4 sts=4 ts=4 et
    autocmd FileType js         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
endif
let _curfile=expand("%:r")
if _curfile == 'Makefile'
    set noexpandtab
endif

" Search setting
set ignorecase
set smartcase
set incsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <Leader>. :vs ~/.config/nvim/init.vim<CR>
nnoremap <Leader>, :new ~/.vimrc<CR>
" inoremap <silent>jj <ESC>
inoremap <C-j> <ESC>
vnoremap <C-j> <ESC>

"" Buffer
set hidden
" walking in buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" buffer -> file
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>W :w!<CR>
nnoremap <Leader>Q :q!<CR>
" window spliting
nnoremap ss :<C-u>sp
nnoremap sv :<C-u>vs
nnoremap sh <C-u><C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sH <C-w>W
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sc <C-w>c
nnoremap so <C-w>o
nnoremap s= <C-w>=
nnoremap s_ <C-w>_

"" Tab pages
nnoremap gk :<C-u>tabedit<CR>
nnoremap gj :<C-u>tabclose<CR>

"" File opening and Save to disks
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
map ,ew :edit %%
map ,es :sp %%
map ,ev :vsp %%
map ,et :tabedit %%

" Visual mode
vnoremap v <C-v>
vnoremap , <ESC>ggVG

" Commandline mode
set history=200
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-j> <ESC><ESC>

" let s:base_dir = expand('~/.vim')
" " runtimepathに追加
" execute 'set runtimepath+=' . fnamemodify(s:base_dir, ':p')
" runtime! dein-nvim.vim
" runtime! tabpage.vim

" Setting some commands
set number
set expandtab
set hlsearch
set formatoptions-=cro
syntax enable
filetype plugin indent on    " required

" inoremap <silent> jj <ESC>
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^a
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^a

" noremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" inoremap ` ``<LEFT>

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

set backspace=indent,eol,start
noremap! <C-?> <C-h>

syntax on

set background=dark
set clipboard=unnamedplus
set t_Co=256
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set ttimeoutlen=50
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 見た目系
" 行番号を表示
" set nu
" 現在の行を強調表示
" set cursorline
" 現在の行を強調表示（縦）
" set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
" set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
" set list listchars=tab:\▸\-"
" set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" 検索系
" 検索文字列jが小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"https://teratail.com/questions/124520"
"{}片方消したらもう片方も消したい"

"---新規カッコ,"クォーテション作成
"---新規カッコ空閉じ,"クォーテション作成
"[ADD] 終わったら括弧の中にカーソルがあるようにする
" inoremap {{ {}<Left>
" inoremap (( ()<Left>
" inoremap [[ []<Left>
" inoremap << <><Left>
" inoremap "" ""<Left>
" inoremap '' ''<Left>
" inoremap `` ``<Left>
" inoremap "<CR> ""<Left>
" inoremap '<CR> ''<Left>
" inoremap `<CR> ``<Left>
""---新規カッコ閉じ　ＣＳＳ書く用---
" inoremap {<CR> {};<Left><Left><CR><ESC><S-o>
" inoremap (<CR> ();<Left><Left><CR><ESC><S-o>
" inoremap [<CR> [];<Left><Left><CR><ESC><S-o>
""---既存タグにカッコつけ--- 行末にカッコつけ
" inoremap {<TAB> {<Right><ESC>$a}
" inoremap (<TAB> (<Right><ESC>$a)
" inoremap [<TAB> [<Right><ESC>$a]
" inoremap "<TAB> "<Right><ESC>$a"
" inoremap '<TAB> '<Right><ESC>$a'
" inoremap `<TAB> `<Right><ESC>$a`

""---既存タグにカッコつけ--- 単語末にカッコつけ
" inoremap {} {<Right><ESC>Ea}
" inoremap () (<Right><ESC>Ea)
" inoremap (/ (<Right><ESC>t/a)
" inoremap (. (<Right><ESC>t.a)
" inoremap [] [<Right><ESC>Ea]
" inoremap <> <<Right><ESC>Ea>
" inoremap ") "<Right><ESC>t)a"
" inoremap "} "<Right><ESC>t}a"
" inoremap "] "<Right><ESC>t]a"
" inoremap ", "<Right><ESC>t,a"
" inoremap ": "<Right><ESC>t:a"
" inoremap "; "<Right><ESC>t;a"
" inoremap ') '<Right><ESC>t)a'
" inoremap '} '<Right><ESC>t}a'
" inoremap '] '<Right><ESC>t]a'
" inoremap ', '<Right><ESC>t,a'
" inoremap ': '<Right><ESC>t:a'
" inoremap '; '<Right><ESC>t;a'
" " ---既存タグにカッコつけ---
" inoremap {<Right> {
" inoremap (<Right> (
" inoremap [<Right> [
" inoremap <<Right> >
" inoremap "<Right> "
" inoremap '<Right> '
" inoremap `<Right> `

" inoremap { {}<Left>
" inoremap {<Enter> {}<Left><CR><ESC><S-o>
" inoremap ( ()<ESC>i
" inoremap (<Enter> ()<Left><CR><ESC><S-o>
set wildmenu
augroup vimrcEx
  autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line('$') |
            \   exe "normal! g`\"" |
                \ endif
                augroup END
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
""autocmd FileType python setl tabstop=8 expandtab shiftwidth=2 softtabstop=2
inoremap <silent> jj <Esc>l
"https://qiita.com/ahiruman5/items/4f3c845500c172a02935"
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" [REMOVE] neovim doesn't need mouse setting
"mouse"
" if has('mouse')
"     set mouse=a
"     if has('mouse_sgr')
"         set ttymouse=sgr
"     elseif v:version > 703 || v:version is 703 && has('patch632')
"         set ttymouse=sgr
"     else
"         set ttymouse=xterm2
"     endif
" endif

if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"
    function XTermPastebegin(ret)
        set paste
        return a:ret
    endfunction
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]

let NERDTreeWinSize=20

if (has("termguicolors"))
 set termguicolors
endif
syntax enable

set keywordprg=:help
"" [deoplete]
" completion after
set isfname-==

" [deoplete] preview disable
" set completeopt-=preview

" https://github.com/Shougo/deoplete.nvim/issues/115
" [deoplete] close after using preview"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '' . title . ''
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
" The prefix key.
nnoremap [Tag] <Nop>
" Tab jump
nmap t [Tag]
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>
" hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
" hi TabLine ctermfg=Blue ctermbg=Yellow
" hi TabLineSel ctermfg=Red ctermbg=Yellow

set mouse=a
set clipboard=unnamedplus,unnamed

noremap <leader>Y :Oscyank<CR>
noremap <leader>y :OscyankRegister<CR>

set runtimepath^=~/dps-helloworld
let g:denops#debug = 1

" set shell=~/.linuxbrew/bin/fish
set shell=/bin/bash
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
set isfname-==
