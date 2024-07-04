vim.g.codeium_disable_default_mappings = 1

vim.keymap.set('i', '<Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
vim.keymap.set('i', '<c-h>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#Clear']() end, { expr = true })

-- because I don't want the default arrow keys to be overriden 
vim.api.nvim_set_keymap('i', '<Up>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Down>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Left>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Right>', '<Right>', { noremap = true, silent = true })
