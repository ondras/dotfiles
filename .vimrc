set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'toupeira/vim-desertink'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'

call vundle#end()

set tabstop=4
set shiftwidth=4
set number
set cursorline
set undolevels=1000

" hide buffers instead of closing them
set hidden

" interactive autocomplete
set wildmenu

" vcs instead
set nobackup
set nowritebackup
set noswapfile

" search: no case, incremental, highlight
set ignorecase
set smartcase
set incsearch
set hlsearch

" respect modelines
set modeline

" make arrows/hl wrap at line beginning/end
set whichwrap+=<,>,h,l

" netrw improvements
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=3

colorscheme desertink

" filetype-based autoindent
filetype plugin indent on

" less invasive matching paren
hi MatchParen term=bold,underline cterm=bold,underline gui=bold,underline ctermbg=none guibg=NONE

" yank to + register (X clipboard)
set clipboard=unnamedplus
