scriptencoding utf-8
"==============================================================
"
" [406]lightline_setting
"  lightline設定
"
"==============================================================

UsePlugin 'lightline.vim'

let g:lightline = {
	\   'colorscheme': 'iceberg',
	\   'active': {
	\       'left': [ ['mode', 'paste'], ['readonly', 'branchName', 'filepath', 'modified'] ]
	\   },
	\   'component_function':{
	\       'filepath': 'FilePath',
    \       'branchName': 'FugitiveHead'
	\   },
	\ }

function! FilePath()
    if winwidth(0) > 90
        return expand("%:s")
    else
        return expand("%:t")
    endif
endfunction

set laststatus=2

