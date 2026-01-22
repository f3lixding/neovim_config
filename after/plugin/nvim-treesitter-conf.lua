-- Since the update, treesitter no longer requires explicit set up call
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- This call is a noop once these parsers are installed once
require 'nvim-treesitter'.install { 'rust', 'javascript', 'zig', 'lua', 'typescript', 'nix', 'bash' }
