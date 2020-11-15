scriptencoding utf-8
"==============================================================
"
" [403]ctrlp_setting
"  CtrlP設定
"
"==============================================================

UsePlugin 'ctrlp.vim'

let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
nnoremap <leader>c :CtrlP<CR>

