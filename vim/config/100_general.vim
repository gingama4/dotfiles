scriptencoding utf-8
"==============================================================
"
" [100]General Setting
"  基本設定
"
"==============================================================

" ミュート
set belloff=all

" 文字コード -------------------------------------------------------------------------- {{{
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,ecu-jp,sjis
set fileformats=unix,dos,mac
" }}}

" シンタックスの有効化
syntax enable

" インデントの設定 -------------------------------------------------------------------- {{{
filetype plugin indent on
set smartindent
set autoindent
" }}}

" タブの設定 -------------------------------------------------------------------------- {{{
set tabstop=4
set shiftwidth=4
" }}}

" バックスペースの設定 ---------------------------------------------------------------- {{{
set backspace=2
set ambiwidth=double
" }}}

" 折りたたみの設定
set foldmethod=marker

" 自動改行の制御
set textwidth=0

" 行番号を表示
set number

" 検索設定 --------------------------------------------------------------------------- {{{
set incsearch
set smartcase
set hlsearch
" }}}

" Undo ------------------------------------------------------------------------------- {{{
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

" カーソルラインの表示 --------------------------------------------------------------- {{{
set cursorline
set cursorlineopt=number
" }}}

" netrwツリー ------------------------------------------------------------------------ {{{
let g:netrw_listtyle=3
let g:netrw_banner=0
let g:netrw_sizestyle='H'
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'
let g:netrw_preview=1

" }}}

" wildmenuを有効化
set wildmenu

