" .vimrc

set nocompatible                " Behave like Vim instead of Vi
set scrolloff=2                 " Show some context
set nobackup                    " Don't make a mess…
set noswapfile                  " …even if there was a crash.
set backspace=indent,eol,start  " Backspace can go anywhere
set history=50		        " keep some history
set ruler		        " show the cursor position
set showcmd		        " display incomplete commands
set incsearch		        " do incremental searching
syntax on                       " Pretty colours…
set hlsearch                    " Make things easy to see

if has('mouse')
    set mouse=a                 " Squeak squeak :3
endif

filetype plugin indent on       " Language-dependant indenting

set expandtab                   " Insert spaces instead of tabs
set softtabstop=4               " The tab key represents four spaces
set shiftwidth=4                " Indentation is also four spaces

" Spell checking
set spelllang=en_nz
set spellfile=$HOME/.vim/spell/words.utf-8.add
set spell

" Whitespace errors
let c_space_errors=1

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

" Make GVim look like regular Vim
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

  colorscheme default
  exe "hi Normal guifg=#C0C0C0 guibg=".background_colour
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

endif

filetype on
au BufNewFile,BufRead *.rs set filetype=rust
