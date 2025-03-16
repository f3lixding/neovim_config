-- keymaps
vim.keymap.set('n', '<leader>dd', require('dap').continue)
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<leader>do', require('dap').step_over)
vim.keymap.set('n', '<leader>di', require('dap').step_into)
vim.keymap.set('n', '<leader>dx', require('dap').close)
vim.keymap.set('n', '<leader>dc', require('dap').disconnect)

-- Configs for attaching to process
local dap = require('dap')

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb'

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
  name = 'lldb',
}

local initialized = {};
local dap_group = vim.api.nvim_create_augroup('DapConfigurations', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = dap_group,
  callback = function(args)
    local filetype = vim.filetype.match({ buf = args.buf }) or vim.bo[args.buf].filetype
    if initialized[filetype] then
      return
    end
    if filetype == 'rust' or filetype == 'c' or filetype == 'cpp' then
      -- for now, because the only things I write are handled by lldb-vscode, so this will do.
      dap.adapters[filetype] = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path)
    elseif filetype == 'typescript' then
      local port = 9229
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = port,
        executable = {
          command = "node",
          args = { "/Users/felixding/dev/js-debug/src/dapDebugServer.js", tostring(port) },
        }
      }
      require("dap").configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          name = 'Attach to process',
          type = 'pwa-node',
          request = 'attach',
          rootPath = '${workspaceFolder}',
          processId = function()
            return vim.fn.input('PID: ')
          end,
          sourceMaps = true,
          resolveSourceMapLocations = {
            '${workspaceFolder}/dist/**/*.js',
            '${workspaceFolder}/dist/**/*.js.map',
            '!**/node_modules/**' -- Explicitly exclude node_modules
          },
          sourceMapPathOverrides = {
            ["../src/*"] = "${workspaceFolder}/src/*"
          },
          outFiles = {
            '${workspaceFolder}/dist/**/*.js',
          },
        },
      }
    elseif filetype == 'zig' then
      dap.configurations[filetype] = {
        {
          name = 'Attach to process',
          type = 'lldb',
          request = 'attach',
          pid = function()
            return tonumber(vim.fn.input('PID: '))
          end,
        },
        {
          name = 'Auto attach',
          type = 'lldb',
          request = 'attach',
          pid = function()
            local signal_file_root = "/tmp";
            local file_pid_path = signal_file_root .. "/.pid";
            local file_pid = io.open(file_pid_path, "r");
            if file_pid then
              local pid = file_pid:read("a");
              print("pid is:" .. pid);
              file_pid:close();
              io.open(signal_file_root .. "/.ready", "w"):close();
              return tonumber(pid);
            end
            return tonumber(vim.fn.input('PID: '))
          end,
        },
        {
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
        },
      }
    end
    initialized[filetype] = true
  end
})

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
