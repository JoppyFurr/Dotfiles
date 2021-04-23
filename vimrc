" .vimrc
set nocompatible                " Behave like Vim instead of Vi
filetype plugin indent on       " Language-dependant indenting
set encoding=utf-8

" Theme
colorscheme wombat
syntax on                       " Highlighting
hi Normal ctermbg=none
hi LineNr ctermbg=none

" Editor settings
set backspace=indent,eol,start  " Backspace can go anywhere
set expandtab                   " Use spaces instead of tabs
set softtabstop=4               " Tabs are four spaces wide
set shiftwidth=4                " Indentation is four spaces wide
set history=50
set linebreak                   " Avoid wrapping in the middle of a word

" File settings
set nobackup
set noswapfile
set autoread                    " Re-read modified files if we've made no edits

" Interface settings
set ruler                       " Show the cursor position
set scrolloff=5                 " Show context
set sidescrolloff=5
set showcmd                     " Display incomplete commands
set tabpagemax=50               " Increase maximum number of tabs
set title                       " Set the window title to the file being edited
if has('mouse')
    set mouse=a
endif

" Search settings
set hlsearch                    " Highlight matches
set incsearch                   " Incremental searching
set ignorecase                  " Case insensitive with a lower-case search string
set smartcase                   " Case sensitive with a mixed-case search string

" Spell checking
set spelllang=en_nz
set spellfile=$HOME/.vim/spell/words.utf-8.add
set spell

" Whitespace errors
let c_space_errors=1

" Use black for column rule
highlight ColorColumn ctermbg=black

" Support for ctags
set tags=./tags;

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

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
