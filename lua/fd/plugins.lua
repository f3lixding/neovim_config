local Plug = vim.fn['plug#']

-- list plugins
vim.call('plug#begin', '~/.config/nvim/plugged')

  -- appearance related
  Plug 'morhetz/gruvbox'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'airblade/vim-gitgutter'

  -- lsp and autocomplete
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp' -- autocomplete main package
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-vsnip' -- snipping engine
  Plug 'hrsh7th/vim-vsnip' -- also for snipping engine
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help' -- for function signature info
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'rmagatti/goto-preview' -- pop up go to definition

  -- rust related
  Plug 'simrat39/rust-tools.nvim'

  -- bracket auto completion
  Plug 'windwp/nvim-autopairs'

  -- telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim' -- required by telescope
  Plug 'ThePrimeagen/harpoon'
  Plug 'nvim-telescope/telescope-live-grep-args.nvim'
  Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })

  -- AI assistant
  Plug 'Exafunction/codeium.vim'

  -- Debugging
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'

vim.call('plug#end')

-- appearance settings
vim.g.gruvbox_number_column = 'bg0'
vim.g.gruvbox_sign_column = 'bg0'
-- vim.g.gruvbox_vert_split = 'bg0'
vim.cmd("highlight link markdownError NONE") -- this is to disable markdown syntax checking https://old.reddit.com/r/neovim/comments/jmuxm0/help_seeing_red_blocks_in_hover_definitions/
vim.cmd("colorscheme gruvbox")
