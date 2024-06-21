-- Basic settings and preferences
vim.g.mapleader = " " -- Set leader key to space

-- Enables syntax highlighting
vim.cmd('syntax enable')

-- Basic Neovim settings
vim.opt.hidden = true -- Required to keep multiple buffers open
vim.opt.wrap = false -- Display long lines as just one line
vim.opt.encoding = 'utf-8' -- Set encoding displayed
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.fileencoding = 'utf-8' -- The encoding written to file
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.cmdheight = 2 -- More space for displaying messages
vim.opt.mouse = 'a' -- Enable mouse input
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.termguicolors = true -- Support 256 colors
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.opt.softtabstop = 2 -- Set the number of space characters for a tab
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smarttab = true -- Smart tabbing
vim.opt.number = true -- Always displays line numbers
vim.opt.exrc = true -- Source any local vim config (if there is any)
vim.opt.guicursor = '' -- Cursor is always a block
vim.opt.relativenumber = true -- Line numbers are relative to current cursor position
vim.opt.errorbells = false -- Disable error warning sounds
vim.opt.hlsearch = false -- Turn highlight search off
vim.opt.undodir = vim.fn.expand('~/.vim/undodir') -- Directory for undo files
vim.opt.undofile = true -- Save undo history to a file
vim.opt.incsearch = true -- Incremental search
vim.opt.scrolloff = 8 -- Gives a bit of breathing room for scrolling
vim.opt.signcolumn = 'yes' -- Dedicated column for linter messages
vim.opt.cursorline = true -- Highlight the current row
vim.opt.statusline = '%<%f' -- Customize the status line
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case insensitive search
