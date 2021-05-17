scriptencoding utf-8
"==============================================================
"
" [401]nerdtree_setting
"  NERDTree設定
"
"==============================================================

UsePlugin 'nerdtree'

autocmd StdinReadPre * let s:std_in=1
let g:NERDTreeShowHidden=1

nnoremap <leader>e :NERDTreeToggle<CR>

