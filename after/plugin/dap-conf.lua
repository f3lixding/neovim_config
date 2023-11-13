-- keymaps
vim.keymap.set('n', '<leader>dd', require('dap').continue)
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', require('dap').continue)
vim.keymap.set('n', '<leader>do', require('dap').step_over)
vim.keymap.set('n', '<leader>di', require('dap').step_into)

-- dap ui 
vim.keymap.set('n', '<leader>du', require('dapui').toggle)
require('dapui').setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t"
  },
})
