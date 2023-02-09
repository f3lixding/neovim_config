-- settings (this needs be sourced before mappings)
vim.cmd("source ~/.config/nvim/settings.vim")

-- mappings
vim.cmd('source ~/.config/nvim/mappings.vim')

-- load plugin related configs
require('fd')
