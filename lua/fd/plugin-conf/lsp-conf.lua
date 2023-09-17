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
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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
end

-- listing servers
local servers = { 'rust_analyzer', 'lua_ls', 'clangd', 'pyright' }

-- prepare settings
local gen_settings = function(server_name)
  if server_name == 'lua_ls' then
    return {
        Lua = {
            diagnostics = {
                globals = { 'vim' } -- need this so the ls doesn't complain about the global variable of vim
            }
        }
    }
  else
    return {}
  end
end

-- calling setups
local nvim_lsp_config = require('lspconfig')
for _, lsp in ipairs(servers) do
  if lsp == 'rust_analyzer' then -- we use rust tools to configure rust_analyzer
    local rt_module = require('fd.plugin-conf.rust-tools-conf')
    rt_module.set_up_rust_tools(on_attach)
  elseif lsp == 'clangd' then
    nvim_lsp_config[lsp].setup {
        on_attach = on_attach,
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        capabilities = capabilities,
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
