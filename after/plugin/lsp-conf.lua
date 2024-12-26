-- Border style
local border_style = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" }
}

-- Hover pop up window customization
vim.cmd [[ hi Pmenu ctermbg=NONE guibg=NONE ]]

-- Override LSP border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border_style
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Setup LSP handlers to use the custom border
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = border_style
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = border_style
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Create autogroup for LSP configuration
local lsp_group = vim.api.nvim_create_augroup('LspConfiguration', { clear = true })

-- Lsp capabilities for lsp servers
-- Track which servers have been set up
local initialized_servers = {}

-- Function to set up servers based on filetype
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = lsp_group,
  callback = function(args)
    local filetype = vim.filetype.match({ buf = args.buf }) or vim.bo[args.buf].filetype
    -- Don't set up if already initialized
    if initialized_servers[filetype] then
      return
    end

    local capabilities = require('fd.plugin-conf.nvim-cmp')
    local nvim_lsp_config = require('lspconfig')

    -- Set up the appropriate server based on filetype
    if filetype == "rust" and not initialized_servers["rust"] then
      initialized_servers["rust"] = true
      vim.g.rustaceanvim = function()
        local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
        local codelldb_path = extension_path .. 'adapter/codelldb'
        local liblldb_path = extension_path .. 'lldb/lib/liblldb'
        local this_os = vim.uv.os_uname().sysname;

        if this_os:find "Windows" then
          codelldb_path = extension_path .. "adapter\\codelldb.exe"
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        else
          liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end
        local cfg = require('rustaceanvim.config')
        return {
          dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
          },
        }
      end
    elseif filetype == "c" or filetype == "cpp" and not initialized_servers["clangd"] then
      initialized_servers["clangd"] = true
      nvim_lsp_config.clangd.setup {
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        capabilities = capabilities,
      }
    elseif filetype == "zig" and not initialized_servers["zls"] then
      initialized_servers["zls"] = true
      local zls_module = require('fd.plugin-conf.zls-conf')
      zls_module.set_up {
        capabilities = capabilities,
      }
    elseif filetype == "python" and not initialized_servers["pyright"] then
      initialized_servers["pyright"] = true
      nvim_lsp_config.pyright.setup {
        capabilities = capabilities,
      }
    elseif filetype == "typescript" and not initialized_servers["ts_ls"] then
      initialized_servers["ts_ls"] = true
      nvim_lsp_config.ts_ls.setup {
        capabilities = capabilities,
      }
    elseif filetype == "lua" and not initialized_servers["lua_ls"] then
      initialized_servers["lua_ls"] = true
      nvim_lsp_config.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            hint = { enable = true },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          }
        }
      }
    end
  end
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local nvim_lsp_config = require('lspconfig')
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    -- Buffer local mappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- Set some keybinds conditional on server capabilities
    if vim.lsp.inlay_hint then
      vim.keymap.set(
        'n',
        '<leader>df',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        { desc = 'Toggle Inlay Hints' }
      )
      -- Set inlay on by default for everything
      vim.lsp.inlay_hint.enable(true)
      vim.api.nvim_set_hl(0, "LspInlayHint", {
        fg = "#808080",
      })
    end
  end
})

-- BufPreWrite formatting
local formatters = {
  ['.rs'] = function(bufnr)
    vim.api.nvim_command('write')
    vim.fn.system('rustfmt --edition 2021 ' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(bufnr)))
    vim.api.nvim_command('edit')
  end,
  ['.zig'] = function(bufnr)
    vim.api.nvim_command('write')
    vim.fn.system('zig fmt ' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(bufnr)))
    vim.api.nvim_command('edit')
  end
}
for ext, formatter in pairs(formatters) do
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*' .. ext,
    group = lsp_group,
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      formatter(bufnr)
    end
  })
end
