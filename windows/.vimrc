"          __
"  __  __ /\_\    ___ ___   _ __   ___
" /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
" \ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
"  \ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"   \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"
"  skanehira respect
" vimrcでマルチバイト文字を使用しているため設定 {{{
scriptencoding utf-8
" }}}

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " .toml file
    let s:rc_dir = expand('~/.vim')
    if !isdirectory(s:rc_dir)
        call mkdir(s:rc_dir, 'p')
    endif
    let s:toml = s:rc_dir . '/dein.toml'

    " read toml and cache
    call dein#load_toml(s:toml, {'lazy': 0})

    " end settings
    call dein#end()
    call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
    call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif
" }}}

" }}}

" general settings {{{

" ミュート {{{
set belloff=all
" }}}

" 文字コード {{{
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
" }}}

" Leaderキーをスペースに設定 {{{
let g:mapleader = "\<Space>"
" }}}

" シンタックスを有効にする {{{
syntax enable
" }}}

" カラースキームを使う {{{
colorscheme iceberg
" }}}

" ファイル形式別プラグインとインデントを有効にする {{{
filetype plugin indent on
" }}}

" バックスペースとCtrl+hで削除を有効にする {{{
set backspace=2
" }}}

" 改行時自動インデント {{{
set smartindent
set autoindent
" }}}

" 自動インデントの空白の数
set shiftwidth=4
" }}}

" 行番号を表示 {{{
set number
" }}}

" タブでも常に空白を挿入 {{{
set tabstop=4
set expandtab
" }}}

" インクリメントサーチを有効にする {{{
set incsearch
" }}}

" 検索時大文字小文字を区別しない {{{
set ignorecase
" }}}

" 検索時に大文字を入力した場合ignorecaseが無効になる {{{
set smartcase
" }}}

" ハイライトサーチを有効にする {{{
set hlsearch
" }}}

" undoできる最大数 {{{
set undolevels=1000
" }}}

" Windowsのクリップボードを共有 {{{
set guioptions+=a
set clipboard^=unnamedplus
" }}}

" カーソルが常に中央に来るようにする {{{
set scrolloff=100
" }}}

" マクロで効果発揮 {{{
set lazyredraw
set ttyfast
" }}}

" 一行が長いファイルをsyntaxを制御することで軽くする {{{
set synmaxcol=256
" }}}

" カーソルラインを表示する {{{
set cursorline
" 描画負担軽減のため、行番号のみハイライト
if !has('nvim')
    set cursorlineopt=number
endif
" }}}

" netrwツリー表示を有効にする {{{
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle='H'
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'
let g:netrw_preview=1
let g:netrw_altv=1
" }}}

" 拡張子ごとのインデントを指定する {{{
augroup fileTypeIndent
    autocmd!
    au BufRead,BufNewFile *.vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au BufRead,BufNewFile *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
    au BufRead,BufNewFile *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au BufRead,BufNewFile *.js   setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au BufRead,BufNewFile *.vue  setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au BufRead,BufNewFile *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
" }}}

" wildmenuを有効にする {{{
set wildmenu
" }}}

" grepした結果をquickfixに表示する {{{
augroup grepwindow
    au!
    au QuickFixCmdPost *grep* cwindow
augroup END
" }}}

" カーソルラインの位置を保存する {{{
augroup cursorlineRestore
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
augroup END
" }}}

" undoの保存先 {{{
if has('persistent_undo')
    let undo_path = expand('~/.vim/undo')
    " ディレクトリが存在しない場合は作成
    if !isdirectory(undo_path)
        call mkdir(undo_path, 'p')
    endif
    exe 'set undodir=' .. undo_path
    set undofile
endif
" }}}

" 矩形選択時に文字の無いところまで選択範囲を広げる {{{
set virtualedit=block
" }}}

" ヘルプの言語を日本語優先にする {{{
set helplang=ja
" }}}

" {{{ 他のバッファに移動する時に自動保存
set autowrite
" }}}

" ファイル保存時に整形する {{{
let s:format_targets = {
            \ 'javascript': '--use-tabs=false --single-quote=true %',
            \ 'html': '--use-tabs=false --single-quote=true %',
            \ 'css': '',
            \ 'json': '--tab',
            \ 'vue':  '--use-tabs=false --single-quote=true %',
            \ 'vim': '',
            \ 'java': '',
            \ }

" format function
function! Format() abort
    " if format target is not exsist, nothing to do
    if !has_key(s:format_targets, &ft)
        return
    endif

    let args = s:format_targets[&ft]
    let pos = getcurpos()

    " use js-beautify to format js, html, css
    if &ft is# 'javascript' || &ft is# 'html' || &ft is# 'vue'
        if executable('prettier')
            exe '%!prettier ' .. args
        else
            call s:echo_err("prettier doesn't installed, please refference the https://github.com/beautify-web/js-beautify")
        endif
    elseif &ft is# 'css'
        " TODO
    elseif &ft is# 'json'
        if executable('jq')
            exe "%!jq " .. args
        else
            call s:echo_err("jq doesn't installed, please refference the https://stedolan.github.io/jq/")
        endif
    else
        execute 'normal 1G=G'
    endif

    call setpos('.', pos)
endfunction

nnoremap <C-f> :call Format()<CR>
" }}}

" プラグインディレクトリ配下の.vimをすべてsourceする {{{
function! SourceDir(...) abort
    let l:path = getcwd()
    if a:0 > 1
        let l:path = a:1
    endif

    if !isdirectory(l:path)
        return
    endif

    exe 'set rtp^=' . l:path
    if isdirectory(l:path . '/plugin')
        exe 'runtime plugin/*.vim'
    endif

    if isdirectory(l:path . '/autoload')
        exe 'runtime autoload/*.vim'
    endif

    if isdirectory(l:path . '/syntax')
        exe 'runtime syntax/*.vim'
    endif
endfunction

command! -nargs=* Source call SourceDir(<f-args>)
" }}}

" listの設定 {{{
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
" }}}

" {{{ 行末のホワイトスペース削除
let s:spaces_target_ft = {
            \ 'markdown': 0,
            \ 'go': 1,
            \ 'javascript': 1,
            \ 'graphql': 1,
            \ 'terminal': 1,
            \ }
augroup HighlightTrailingSpaces
    autocmd!
    autocmd BufWritePre * if get(s:spaces_target_ft, &ft, 0) | :silent keeppatterns %s/\s\+$//ge | endif
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    autocmd VimEnter,WinEnter * if get(s:spaces_target_ft, &ft, 0) | match TrailingSpaces /\s\+$/ | endif
augroup END
" }}}

" swapファイルを作成しない
set noswapfile

" {{{ セッションで保存する対象を設定する
if !has('nvim')
    set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
endif
" }}}

" ウィンドウサイズ自動調整を無効化
set noequalalways

" タブを常に表示
set showtabline=2

" {{{ 外部でファイルの変更があった場合、自動的に読み直す
set autoread
augroup vimrc-misc
    au!
    autocmd WinEnter,FocusGained * checktime
augroup END
" }}}

" key mappings {{{
" *でカーソルを移動しないようにする
noremap * *N

" jjでINSERTを脱出
inoremap jj <Esc><CR>

" ファイル保存と終了 {{{
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q!<CR>
" }}}

" 検索
nnoremap <C-G><C-G> :Ggrep <C-R><C-W><CR><CR>

" 置換
nnoremap <Leader>re :%s;\<<C-R><C-W>\>;g<Left><Left>;

" visualで選択したテキストを置換する
vnoremap <Leader>re y:%s;<C-r>=substitute(@", "<C-v><NL>", "\\\\n", "g")<CR>;;g<Left><Left>

" ハイライトを削除する
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" vimrcを開く
nnoremap <Leader>. :new ~/.vimrc<CR>
nnoremap <Leader>s :source ~/.vimrc<CR>

nnoremap <Leader>, :new ~/.vim/dein.toml<CR>

" テキストオブジェクトキーマッピング {{{
onoremap 8 i(
onoremap 2 i"
onoremap 7 i'
onoremap @ i`
onoremap [ i[
onoremap { i{

onoremap a8 a(
onoremap a2 a"
onoremap a7 a'
onoremap a@ a`
onoremap a[ a[
onoremap a{ a{

" visual
nnoremap v8 vi(
nnoremap v2 vi"
nnoremap v7 vi'
nnoremap v@ vi`
nnoremap v[ vi[
nnoremap v{ vi{

nnoremap va8 va(
nnoremap va2 va"
nnoremap va7 va'
nnoremap va@ va`
nnoremap va[ va[
nnoremap va{ va{
" }}}

" ウィンドウ移動 {{{
nnoremap <Leader>h <C-w>h<CR>
nnoremap <Leader>j <C-w>j<CR>
nnoremap <Leader>k <C-w>k<CR>
nnoremap <Leader>l <C-w>l<CR>
" }}}

" 行先頭と行末
noremap H ^
noremap L g_

" タブ切り替え
nnoremap <C-l> gt
nnoremap <C-h> gT

" numberとrelativenumberの切り替え
nnoremap <silent> <Leader>n :set relativenumber!<CR>

" ターミナル関連 {{{
" ターミナルノーマルモード
tnoremap <C-w>n <C-w>N

" ターミナルでウィンドウ移動
tnoremap <silent> <C-h> <C-w>:tabprevious<CR>
tnoremap <silent> <C-l> <C-w>:tabnext<CR>

" <c-g>を<c-w>代わりにする
tnoremap <C-g> <C-w>.
" }}}

" 上下の空白に移動
nnoremap <C-j> }
nnoremap <C-k> {

" review
augroup review
    au!
    au FileType review vnoremap <silent> <buffer> <Leader>hi c@<cursor>{<c-r>"}<esc>
augroup END

" 改行
nnoremap gj o<esc>
nnoremap gk O<esc>

" git status
nnoremap gs :Gstatus<CR>

" バッファ一覧
nnoremap gb :Buffers<CR>

" ヘルプ
augroup help-mapping
    au!
    au FileType help nnoremap <buffer> <silent>q :bw!<CR>
augroup END

" }}}

" コマンドラインで単語移動 {{{
cnoremap <c-b> <S-Left>
cnoremap <c-f> <S-Right>
cnoremap <c-a> <Home>
" }}}

" Plugin Settings {{{

" fzf settings {{{
" ファイル一覧を出すときにプレビュー表示
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <C-P> :Files<CR>
" }}}

" lsp settings {{{
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nnoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
au!
autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
"let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_auto_completeopt = 0
"let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

" }}}

" {{{ WSLのクリップボード設定
"if $WSL_DISTRO_NAME != ''
"    augroup yankpost
"        au!
"        autocmd TextYankPost * echo v:event
"        autocmd TextYankPost * call system('win32yank.exe -i', v:event.regcontents + [''])
"    augroup END
"
"    noremap <silent> <Leader>p :call setreg('"',system('win32yank.exe -o'))<CR>
"endif
" }}}

" }}}

" {{{ 自作関数

" {{{ ポップアップウィンドウでターミナル
command! Terminal call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: winwidth(0)/2, minheight: &lines/2 })
" }}}

" {{{ リポジトリに移動
function! s:cd_repo(shell, repo) abort
    exe 'lcd' trim(system('ghq root')) .. '/' .. a:repo
    pwd
endfunction

function! s:repo(multi, cb) abort
    if executable('ghq') && exists('*fzf#run()') && executable('fzf')
        call fzf#run({
                    \ 'source': systemlist('ghq list'),
                    \ 'sink': a:cb,
                    \ 'options': a:multi,
                    \ 'down': '40%'},
                    \ )
    else
        echo "doesn't installed ghq or fzf.vim(require fzf)"
    endif
endfunction

command! Repo call s:repo('+m', function('s:cd_repo', [&shell]))
" }}}

" 新しいタブを開く {{{
function! s:open_tabs(shell, repo) abort
    exe printf('tabnew | lcd %s/%s', trim(system('ghq root')), a:repo)
endfunction

" fzf.vimのcallbackでは&shellがshになってしまうので、現在実行しているshellを渡す
command! NewTab call s:repo('-m', function('s:open_tabs', [&shell]))

" }}}

" {{{ エラーメッセージ出力
function! s:echo_err(message) abort
    echohl ErrorMsg
    redraw
    echo a:message
    echohl None
endfunction
" }}}

" {{{ gitコマンド関連
" options:
" {
"	cmd: 'diff'
"	args: [
"		'HEAD^',
"	],
"	auto_close: 0,	" 1: true, 0: false
"	window_way: 'bo',	" tab, bo, vert, term, etc...
"	mode: 'term', " term, popup, fzf
"	focus: 1008, " window id
"	source: [], " fzf source
"	cb: functionm "fzf callback
" }
function! s:git_exec(opt) abort
    let current_winid = win_getid()
    if a:opt.mode is# 'term'
        let cmd = 'git ' .. a:opt.cmd
        if has_key(a:opt, 'args') && !empty(a:opt.args)
            let cmd = cmd .. ' ' .. join(a:opt.args, ' ')
        endif
        if has_key(a:opt, 'auto_close') && a:opt.auto_close is# 1
            let cmd = a:opt.window_way .. ' term ++rows=10 ++close ' .. cmd
        else
            let cmd = a:opt.window_way .. ' term ++rows=10 ' .. cmd
        endif
        exec cmd
        nnoremap <buffer> <silent> q :bw!<CR>
    elseif a:opt.mode is# 'pop'
        " TODO use popup window
    elseif a:opt.mode is# 'fzf'
        if exists('*fzf#run()') && executable('fzf')
            call fzf#run({
                        \ 'source': a:opt.source,
                        \ 'sink': a:opt.cb,
                        \ 'down': '40%'},
                        \ )
        endif
    else
        call s:echo_err("doesn't installed fzf.vim(require fzf)")
    endif

    call win_gotoid(current_winid)
endfunction

function! s:git_log() abort
    " use fish command
    call system('tmux new-window git log')
endfunction

function! s:git_push(...) abort
    let opt = {
                \ 'cmd': 'push',
                \ 'args': a:000,
                \ 'auto_close': 1,
                \ 'window_way': 'top',
                \ 'mode': 'term',
                \ }

    call s:git_exec(opt)
endfunction

function! s:git_pull(...) abort
    let opt = {
                \ 'cmd': 'pull',
                \ 'args': a:000,
                \ 'auto_close': 1,
                \ 'window_way': 'top',
                \ 'mode': 'term',
                \ }

    call s:git_exec(opt)
endfunction

function! s:git_checkout_cb(repo) abort
    call system('git checkout' .. a:repo)
endfunction

function! s:git_checkout(...) abort
    let source = filter(systemlist('git branch'), 'v:val[0] isnot# "*"')
    if empty(source)
        call s:echo_err("no other branch")
        return
    endif

    let opt = {
                \ 'source': source,
                \ 'mode': 'fzf',
                \ 'cb': function('s:git_checkout_cb'),
                \ }

    call s:git_exec(opt)
endfunction

command! -nargs=* Gitpush call s:git_push(<f-args>)
command! -nargs=* Gitpull call s:git_pull()
command! -nargs=* Gitblame call s:git_blame()
command! -nargs=* GitCheckout call s:git_checkout(<f-args>)
command! Gitlog call s:git_log()
command! Lazygit call system('tmux new-window lazygit')
command! Pst call system('tmux split-window -h pst')
command! Docui call system('tmux new-window docui')
command! FF call system('tmux split-window -h ff')

nnoremap <silent> gl :Lazygit<CR>
nnoremap <silent> gc :GitCheckout<CR>

" }}}

" {{{ バッファ関連
function! s:buflist() abort
    return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function! s:format_buffer(b)
    let name = bufname(a:b)
    let name = empty(name) ? '[No Name]' : fnamemodify(name, ":p:~:.")
    let flag = a:b == bufnr('')  ? '%' : a:b == bufnr('#') ? '#' : ' '
    let modified = getbufvar(a:b, '&modified') ? ' [+]' : ''
    let readonly = getbufvar(a:b, '&modifiable') ? '' : ' [RO]'
    let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
    return printf("[%s] %s\t%s\t%s", a:b, flag, name, extra)
endfunction

function! s:delbuf(buf) abort
    exe 'bw!' a:buf[match(a:buf, '[')+1:match(a:buf, ']')-1]
endfunction

function! s:delbuflist() abort
    call fzf#run({
                \ 'source': map(copy(s:buflist()), 's:format_buffer(v:val)'),
                \ 'sink': function('s:delbuf'),
                \ 'options': "-m",
                \ 'down': '40%'},
                \ )
endfunction

command! DelBuf call s:delbuflist()
" }}}

" {{{ ディレクトリ自動生成
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
                    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END
" }}}

" }}}
" vim: tw=78 sw=4 foldmethod=marker
