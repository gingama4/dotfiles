"
" init.vim for NeoVim
"
" gingama4's init.vim
scriptencoding utf-8

let s:plugin_manager = 'jetpack.vim'

let s:autoload_dir = expand('$HOME/.config/nvim/autoload')
let s:plug_dir = s:autoload_dir . '/' . s:plugin_manager

" plugin manager installation check {{{
if &runtimepath !~# '/' . s:plugin_manager
	if !isdirectory(s:autoload_dir)
		execute '!curl -fLo ' . s:plug_dir . ' --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/autoload/jetpack.vim'
	endif
	execute 'set runtimepath^=' . s:plug_dir
endif
" }}}

call jetpack#begin()



call jetpack#end()
