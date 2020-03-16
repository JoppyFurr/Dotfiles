" .vimrc
set nocompatible                " Behave like Vim instead of Vi
colorscheme default

filetype plugin indent on       " Language-dependant indenting
syntax on                       " Highlighting
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

" GUI Colour scheme
hi SpecialKey      guifg=#D3D7CF
hi NonText         guifg=#D3D7CF
hi Directory       guifg=#3465A4
hi ErrorMsg        guifg=#FFFFFF guibg=#CC0000
hi Search          guifg=#000000 guibg=#C4A000
hi MoreMsg         guifg=#8AE234
hi LineNr          guifg=#C4A000
hi Question        guifg=#8AE234
hi Title           guifg=#AD7FA8
hi WarningMsg      guifg=#EF2929
hi WildMenu        guifg=#000000 guibg=#C4A000
hi Folded          guifg=#06989A guibg=#2E3436
hi FoldColumn      guifg=#06989A guibg=#2E3436
hi SignColumn      guifg=#3465A4
hi Pmenu                         guibg=#AD7FA8
hi PmenuSel                      guibg=#2E3436
hi PmenuSbar                     guibg=#2E3436
hi TabLine         guifg=#EEEEEC guibg=#2E3436
hi CursorColumn                  guibg=#2E3436
hi Comment         guifg=#3465A4
hi Constant        guifg=#CC0000
hi Special         guifg=#EF2929
hi Identifier      guifg=#06989A
hi Statement       guifg=#C4A000
hi PreProc         guifg=#75507B
hi Type            guifg=#4E9A06
hi Underlined      guifg=#729FCF
hi Ignore          guifg=#2E3436
hi Error           guifg=#FFFFFF guibg=#CC0000
hi Todo            guifg=#000000 guibg=#C4A000

" GVim settings
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Terminus\ 9
    set guioptions-=T " Hide toolpar
    set guioptions-=r " Hide scrollbar
  endif

  let background_colour=system("~/Scripts/ColourBg.sh")
  if v:shell_error
    let background_colour="#101010"
  endif

  exe "hi Normal guifg=#C0C0C0 guibg=".background_colour
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
