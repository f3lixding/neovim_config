" basic settings and preferences
let g:mapleader = "\<Space>"

syntax enable                                               " Enables syntax highlighting
set hidden                                                  " Required to keep multiple buffers open
set nowrap                                                  " Display long lines as just one line
set encoding=utf-8                                          " Set encoding displayed
set pumheight=10                                            " Makes popup menu smaller
set fileencoding=utf-8                                      " The encoding written to file
set ruler                                                   " Show the cursor position all the time
set cmdheight=2                                             " Height for space that displays messages
set mouse=a                                                 " Enable mouse input
set splitbelow                                              " Horizontal splits will automatically be below
set splitright                                              " Vertical splits will automatically be to the right
set t_Co=256                                                " Support 256 colors
set tabstop=2                                               " Insert 2 spaces for a tab
set shiftwidth=2                                            " Change the number of space characters inserted for indentation
set softtabstop=2                                           " Set the number of columns of ws a tab or backspace does 
set expandtab                                               " Converts tabs to spaces
set smarttab                                                " Smart tabbing 
set number                                                  " Always displays line number
set exrc                                                    " Source any local vim config (if there is any) 
set guicursor=                                              " Cursor is always a block
set relativenumber                                          " Line numbers are relative to current cursor position
set noerrorbells                                            " Disable error warning sounds
set nohlsearch                                              " Turn highlight search off
set undodir=~/.vim/undodir                                  " Dir for undo file 
set undofile                                                " Set undo file
set incsearch                                               " Set incremental search
set scrolloff=8                                             " Gives a bit of breathing room for scrolling
set signcolumn=yes                                          " Gives a dedicated column for linter messages
set cursorline                                              " highlight current row
