-- This makes yank copy from cursor pos to EOL
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Better window resize (Mac)
vim.api.nvim_set_keymap('n', '∆', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '˚', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '˙', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '¬', ':vertical resize -2<CR>', { noremap = true, silent = true })

-- Better window resize (Linux)
vim.api.nvim_set_keymap('n', '<A-j>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-h>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', ':vertical resize -2<CR>', { noremap = true, silent = true })

-- For when you use the laptop's keyboard
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true })

-- Better tabbing
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Better window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Better terminal instantiation
vim.api.nvim_set_keymap('n', '<leader>tj', '<cmd>bo split<CR><cmd>term<CR><cmd>res 20<CR>', { noremap = true })

-- Nvim tree commands
vim.api.nvim_set_keymap('n', '<leader>fe', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true })
