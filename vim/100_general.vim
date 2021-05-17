scriptencoding utf-8
"==============================================================
"
" [100]General Setting
"  基本設定
"
"==============================================================

" ミュート
set belloff=all

" 文字コード {{{
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,ecu-jp,sjis
set fileformats=unix,dos,mac
" }}}

" シンタックスの有効化
syntax enable

" 背景の透過 {{{
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 
" }}}

" インデントの設定 {{{
filetype plugin indent on
set smartindent
set autoindent
" }}}

" タブの設定 {{{
set expandtab
set tabstop=2
set shiftwidth=2
" }}}

" バックスペースの設定 {{{
set backspace=2
set ambiwidth=double
" }}}

" 折りたたみの設定
set foldmethod=marker

" 自動改行の制御
set textwidth=0

" 行番号を表示
set number

" 検索設定 {{{
set incsearch
set smartcase
set hlsearch
" }}}

" Undo {{{
set undolevels=1000
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif
" }}}

" クリップボード
set clipboard=unnamed

" カーソルが中央に来るようにする
set scrolloff=100

" カーソルラインの表示 {{{
set cursorline
set cursorlineopt=number
" }}}

" netrwツリー {{{
let g:netrw_listtyle=3
let g:netrw_banner=0
let g:netrw_sizestyle='H'
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'
let g:netrw_preview=1

" }}}

" wildmenuを有効化
set wildmenu

" swapファイルを無効化
set noswapfile

" ウィンドウサイズ自動調整を無効化
set noequalalways

" タブを常に表示
set showtabline=2

" {{{ 外部でファイルの変更があった場合、自動読み込み
set autoread
augroup vimrc-misc
	au!
	autocmd WinEnter, FocusGained * checktime
augroup END
" }}}

" {{{ モードによってカーソルを変更する
if has('vim_starting')
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif
" }}}
