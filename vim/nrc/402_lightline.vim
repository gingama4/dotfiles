scriptencoding utf-8
" =============================================== 
" lightline.vim
"
" lightline configuration
" =============================================== 

UsePlugin 'lightline.vim'
UsePlugin 'iceberg.vim'

let g:lightline = {
      \  'colorscheme': 'iceberg',
      \  'active': {
      \    'left': [ [ 'mode', 'pasete' ], 
      \              [ 'readonly', 'gitbranch', 'filename', 'modified' ] ]
      \  },
      \  'component': {
      \    'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \  },
      \  'component_function': {
      \    'gitbranch': 'Gitbranch',
      \  },
      \  'component_visible_condition': {
      \    'readonly': '(&filetype!="help"&& &readonly)',
      \  }
      \}

"let g:lightline = {
"      \  'colorscheme': 'iceberg',
"      \  'active': {
"      \    'left': [ [ 'mode', 'pasete' ], 
"      \              [ 'readonly', 'fugitive', 'filename', 'modified' ] ]
"      \  },
"      \  'component': {
"      \    'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
"      \    'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
"      \  },
"      \  'component_visible_condition': {
"      \    'readonly': '(&filetype!="help"&& &readonly)',
"      \    'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
"      \  }
"      \}


function! Gitbranch()
  let s:git_branch = ""
  let s:branch = gin#component#branch#unicode()
  if s:branch != ""
    return s:git_branch . s:branch
  endif
  return s:branch
endfunction

