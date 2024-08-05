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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local capabilities = require('fd.plugin-conf.nvim-cmp')
local on_attach = function(_, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
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
  end
end

-- listing servers
local servers = { 'rust_analyzer', 'lua_ls', 'clangd', 'pyright', 'zls' }

-- prepare settings
local gen_settings = function(server_name)
  if server_name == 'lua_ls' then
    return {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            hint = { enable = true },
            workspace = {
                -- Make the server aware of Neovim runtime files to provide settings for `vim` API, etc.
                library = vim.api.nvim_get_runtime_file("", true),
            },
        }
    }
  else
    return {}
  end
end

-- calling setups
local nvim_lsp_config = require('lspconfig')
for _, lsp in ipairs(servers) do
  if lsp == 'rust_analyzer' then
    vim.g.rustaceanvim = function()
      local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb'
      local this_os = vim.uv.os_uname().sysname;

      -- The path is different on Windows
      if this_os:find "Windows" then
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
      else
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
      end

      local cfg = require('rustaceanvim.config')
      return {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
          on_attach = on_attach,
            -- you can also put keymaps in here
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
            },
          },
        },
        -- DAP configuration
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  elseif lsp == 'clangd' then
    nvim_lsp_config[lsp].setup {
        on_attach = on_attach,
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        capabilities = capabilities,
    }
  elseif lsp == 'zls' then
    local zls_module = require('fd.plugin-conf.zls-conf')
    zls_module.set_up {
        capabilities = capabilities,
        on_attach_routine = on_attach,
    }
  else
    nvim_lsp_config[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = gen_settings(lsp),
    }
  end
end

-- autocommands for formatting for rust
function rustfmt()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_command('write') -- Write the file first
  vim.fn.system('rustfmt --edition 2021 ' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(bufnr)))
  vim.api.nvim_command('edit') -- Reload the buffer
end

vim.cmd('autocmd BufWritePre *.rs lua rustfmt()')
