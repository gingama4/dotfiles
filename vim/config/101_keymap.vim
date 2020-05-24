scriptencoding utf-8
"==============================================================
"
" [101]Keymap Setting
"  キーマップ設定
"
"==============================================================

" Leaderキーの設定
let g:mapleader = "\<Space>"

" ウィンドウ移動 --------------------------------------------------------------------- {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" vimrc ------------------------------------------------------------------------------ {{{
" 新規タブでvimrcフォルダを開く
nnoremap <leader>. :tabe ~/dotfiles/vim/config<CR>
" vimrcを読み込む
nnoremap <leader>s :source $MYVIMRC<CR>
" }}}

