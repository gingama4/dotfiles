scriptencoding utf-8
" =============================================== 
" plugin.vim
"
" Load vim/nvim plugin
"
" common : install vim & neovim
" vim : install only vim
" neovim : install only neovim
" =============================================== 

" install dir {{{
let s:autoload_dir = g:vim_home . '/autoload'
let s:plug_dir = s:autoload_dir . '/plug.vim'
let s:plugged_dir = g:vim_home . '/plugged'
" }}}

if &runtimepath !~# '/plug.vim'
  if !isdirectory(s:autoload_dir)
    execute '!curl -fLo ' . s:plug_dir . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
  execute 'set runtimepath^=' . s:plug_dir
endif

call plug#begin(s:plugged_dir)

" common {{{
Plug 'vim-jp/vimdoc-ja'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-matchfuzzy'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

" Not installed with VSCode
if !exists('g:vscode')
  Plug 'cocopon/iceberg.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
endif
" }}}

" vim {{{
if !has('nvim')
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-lsp-icons'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
endif
" }}}

" neovim {{{
if has('nvim')
endif
" }}}

call plug#end()
