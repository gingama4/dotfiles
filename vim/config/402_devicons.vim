scriptencoding utf-8
"==============================================================
"
" [402]devicons_setting
"  devicons設定
"
"==============================================================

UsePlugin 'vim-devicons'

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true

if exists('g:loaded_webdevicons')
	call webdevicons#refresh()
endif

