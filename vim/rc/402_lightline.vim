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
      \              [ 'readonly', 'fugitive', 'filename', 'modified' ] ]
      \  },
      \  'component': {
      \    'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \    'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
      \  },
      \  'component_visible_condition': {
      \    'readonly': '(&filetype!="help"&& &readonly)',
      \    'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \  }
      \}
