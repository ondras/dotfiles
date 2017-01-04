set tabstop=4
set shiftwidth=4
set number
set undolevels=1000

" hide buffers instead of closing them
set hidden

" interactive autocomplete
set wildmenu

" vcs instead
set nobackup
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

colorscheme desert

" filetype-based autoindent
filetype indent on

" less invasive matching paren
hi MatchParen term=bold,underline cterm=bold,underline ctermbg=none guibg=NONE

" yank to + register (X clipboard)
set clipboard=unnamedplus
