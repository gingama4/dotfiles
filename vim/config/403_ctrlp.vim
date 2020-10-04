scriptencoding utf-8
"==============================================================
"
" [403]ctrlp_setting
"  CtrlP設定
"
"==============================================================

if empty(globpath(&rtp, 'autoload/ctrlp.vim'))
    finish
endif

let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
nnoremap <leader>c :CtrlP<CR>

