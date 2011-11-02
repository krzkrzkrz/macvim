" Pathogen settings
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible

set number
set ruler
set cursorline
syntax on

" Disable all blinking
set guicursor+=a:blinkon0

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
" set cindent             " Disable for now because >> doesnt not indent lines, if starting char is #
" set smartindent         " Disable for now because >> doesnt not indent lines, if starting char is #
set autoindent
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Status bar
set laststatus=2

" Start without the toolbar
set guioptions-=T

" Default gui color scheme
" "color default
" color molokai
color railscasts+

" Command-/ to toggle comments
map <D-/> :TComment<CR>j

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru} set ft=ruby

" Open split buffers below instead of above current buffer
set splitbelow

" Session options
let g:session_autoload = 1
let g:session_autosave = 1

" Buffer navigation
map <C-K> <C-W><C-K>
map <C-J> <C-W><C-W>
map <C-H> <C-W><C-H>
map <C-L> <C-W><C-L>

" Rails navigation options
nmap <leader>rc :Rcontroller 
nmap <leader>rv :Rview 
nmap <leader>rm :Rmodel 

" Tab completion
" Also needed for better Rails navigation auto-completion
set wildmode=list:longest,list:full

" Open up side panel left (NERDTree) and right(Tagbar)
" nmap <leader>\ :NERDTreeToggle<CR> :TagbarToggle<CR>
nmap <leader>\ :call ToggleNERDTreeAndTagbar()<CR>

" Allow single click for NERDTree
let NERDTreeMouseMode = 3
let g:NERDTreeWinSize = 30
" autocmd VimEnter * NERDTree

" Tagbar options
let tagbar_singleclick = 1
let g:tagbar_sort = 0
let g:tagbar_width = 30
" autocmd VimEnter * nested TagbarOpen

" The Janus plugin sets this to noequalalways for the Zoominfo plugin
" However, we want to set this to equalalways instead, since we want to
" have equal window height when a new window is opened. i.e. via ctrl+w+s
set equalalways

" Matchit already installed in newer versions of vim.
" Don't need to add this onto pathogen bundle folder. We only need
" to configure it.
" Configure matchit so that it goes from opening tag to closing tag
" au FileType html,eruby,rb,css,js,xml runtime! macros/matchit.vim
" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Set backup and swp dir. Don't forget to clear tmp dir out once in a while
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swp

" Detect if a tab was closed, and ensure that height of main window fills the screen (100% height)
au TabEnter * let &lines = 100

" <leader>\ to open or close NERDTree and Tagbar, under the following conditions:
" 1) Only close both if NERDTree and Tagbar are both opened
" 2) Open both if NERDTree and Tagbar are closed OR if one is already opened
function! ToggleNERDTreeAndTagbar()
  let w:jumpbacktohere = 1

  " Detect which plugins are open
  if exists('t:NERDTreeBufName')
      let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
  else
      let nerdtree_open = 0
  endif
  let tagbar_open = bufwinnr('__Tagbar__') != -1

  " Perform the appropriate action
  if nerdtree_open && tagbar_open
      NERDTreeClose
      TagbarClose
  elseif nerdtree_open
      TagbarOpen
  elseif tagbar_open
      NERDTree
  else
      NERDTree
      TagbarOpen
  endif

  " Jump back to the original window
  for window in range(1, winnr('$'))
    execute window . 'wincmd w'
    if exists('w:jumpbacktohere')
      unlet w:jumpbacktohere
      break
    endif
  endfor
endfunction

