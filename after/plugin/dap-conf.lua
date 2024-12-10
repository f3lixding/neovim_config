-- keymaps
vim.keymap.set('n', '<leader>dd', require('dap').continue)
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<leader>do', require('dap').step_over)
vim.keymap.set('n', '<leader>di', require('dap').step_into)
vim.keymap.set('n', '<leader>dx', require('dap').close)
vim.keymap.set('n', '<leader>dc', require('dap').disconnect)

-- Configs for attaching to process
local dap = require('dap')
local buffer_types = { 'rust', 'c', 'cpp', 'zig' }

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb'

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
  name = 'lldb',
}

for _, buf_type in ipairs(buffer_types) do
  dap.configurations[buf_type] = {
    {
      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      name = "Attach to process",
      type = buf_type, -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
    },
    {
      name = "Launch a process",
      type = buf_type, -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      args = {},
    },
  }

  if buf_type == 'rust' or buf_type == 'c' or buf_type == 'cpp' then
    -- for now, because the only things I write are handled by lldb-vscode, so this will do.
    dap.adapters[buf_type] = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path)
  elseif buf_type == 'zig' then
    dap.configurations[buf_type] = { {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to binary: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = function()
        local user_input = vim.fn.input("Arguments (separated by space): ")
        return user_input
      end,
    } }
  end
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
