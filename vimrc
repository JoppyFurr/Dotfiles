" .vimrc
set nocompatible                " Behave like Vim instead of Vi
filetype plugin indent on       " Language-dependant indenting
set encoding=utf-8

" Theme
colorscheme wombat
syntax on                       " Highlighting
hi Normal ctermbg=none
hi LineNr ctermbg=none

set scrolloff=5                 " Show some context
set nobackup                    " Don't make a mess…
set noswapfile                  " …even if there was a crash.
set backspace=indent,eol,start  " Backspace can go anywhere
set history=50		        " keep some history
set ruler		        " show the cursor position
set showcmd		        " display incomplete commands
set incsearch		        " do incremental searching
set ignorecase                  " Case insensitive if search-string is all lower case
set smartcase                   " Case sensitive if search-string contains any upper case
set hlsearch                    " Make things easy to see

if has('mouse')
    set mouse=a                 " Squeak squeak :3
endif

set expandtab                   " Insert spaces instead of tabs
set softtabstop=4               " Tabs are four spaces wide
set shiftwidth=4                " Indentation is four spaces wide

" Spell checking
set spelllang=en_nz
set spellfile=$HOME/.vim/spell/words.utf-8.add
set spell

" Whitespace errors
let c_space_errors=1

" Use black for column rule
highlight ColorColumn ctermbg=black

" Cscope is handy for larger projects.
function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
au BufEnter /* call LoadCscope()

" GVim settings
if has("gui_running")
    set guifont=Terminus\ (TTF)\ Medium\ 12
    set guioptions-=T " Hide tool-bar
    set guioptions-=r " Hide scrollbar
endif

" File-specific configuration
autocmd BufNewFile,BufRead Notes :source ~/Notes.vim

autocmd BufNewFile,BufRead */linux/**
    \ set noexpandtab   |
    \ set softtabstop=8 |
    \ set shiftwidth=8  |
    \ set cc=80

autocmd BufNewFile,BufRead */uboot/**
    \ set noexpandtab   |
    \ set softtabstop=8 |
    \ set shiftwidth=8  |
    \ set cc=80

" For Lightline
set noshowmode
set laststatus=2
let g:lightline = { 'colorscheme' : 'wombat' }
