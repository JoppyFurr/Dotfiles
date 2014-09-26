" Make things more friendly
set nocompatible
set scrolloff=2
set nobackup
set noswapfile
set backspace=indent,eol,start


set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Squeak squeak :3
if has('mouse')
    set mouse=a
endif

" Pretty colours…
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Use four spaces instead of tab. Use four spaces for auto-indent.
set et
set sw=4
set sts=4
set smarttab

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

