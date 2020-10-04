scriptencoding utf-8
"==============================================================
"
" [401]nerdtree_setting
"  NERDTree設定
"
"==============================================================

if empty(globpath(&rtp, 'autoload/nerdtree.vim'))
    finish
endif

autocmd StdinReadPre * let s:std_in=1
let g:NERDTreeShowHidden=1

nnoremap <leader>e :NERDTreeToggle<CR>

