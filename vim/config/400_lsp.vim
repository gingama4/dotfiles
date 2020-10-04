scriptencoding utf-8
"==============================================================
"
" [400]lsp_setting
"  LSP設定
"
"==============================================================

if empty(globpath(&rtp, 'autoload/lsp.vim'))
    finish
endif

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> <f2> <plug>(lsp-rename)
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursot = 1
let g:lsp_text_edit_enabled = 1

let g:asyncomplete_auto_completeopt = 0

set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

