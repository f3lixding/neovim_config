-- keymaps
vim.keymap.set('n', '<leader>dd', require('dap').continue)
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<leader>do', require('dap').step_over)
vim.keymap.set('n', '<leader>di', require('dap').step_into)

-- Configs for attaching to process
local dap = require('dap')
local buffer_types = { 'rust' }

for _, buf_type in ipairs(buffer_types) do
  dap.configurations[buf_type] = {
      {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = "Attach to process",
        type = buf_type,  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
      },
  }

  dap.adapters[buf_type] = require('fd.plugin-conf.rust-tools-conf').dap
end

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
