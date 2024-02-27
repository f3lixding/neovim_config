-- set the color theme first
vim.cmd("highlight link markdownError NONE") -- this is to disable markdown syntax checking https://old.reddit.com/r/neovim/comments/jmuxm0/help_seeing_red_blocks_in_hover_definitions/
vim.cmd("colorscheme gruvbox")

-- treesitter specific settings
vim.api.nvim_set_hl(0, "@variable", { link = "GruvBoxBlue" })
vim.api.nvim_set_hl(0, "Delimiter", { link = "GruvBoxOrange" })

-- background color adjustment to see background picture
vim.api.nvim_set_hl(0, "Normal", {bg = "NONE", fg = "NONE", sp = "NONE"})
vim.api.nvim_set_hl(0, "LineNr", {fg = "#555555"})

-- background color for borders
vim.api.nvim_set_hl(0, "WinSeparator", {fg = "#555555"})
vim.g.gruvbox_number_column = 'bg0'
vim.g.gruvbox_sign_column = 'bg0'

-- Set background color for floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

-- Set background and foreground (border color) for floating window borders
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "#ffffff" })

