scriptencoding utf-8
" =============================================== 
" lsp.vim
"
" Language Server Protocol Configuration
" =============================================== 

UsePlugin 'vim-lsp'

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  nmap <buffer> gd :tab LspDefinition<CR>
  nmap <buffer> K <plug>(lsp-hover)

  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <Down>   pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>": "\<S-Tab>"
  inoremap <expr> <Up> pumvisible() ? "\<C-p>": "\<Up>"
  inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

  " go
  autocmd! BufWritePre *.go call execute(['LspCodeActionSync source.organizeImports', 'LspDocumentFormatSync'])
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
