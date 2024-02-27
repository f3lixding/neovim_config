local M = {}

function M.set_up(options)
  require("lspconfig").zls.setup {
    settings = {
      zls = {
        -- Ensure this matches the zls configuration for inlay hints
        -- This is just an example; refer to zls documentation for exact settings
        enableInlayHints = true,
        inlay_hints_show_variable_type_hints = true,
        inlay_hints_show_struct_literal_field_type = true,
        inlay_hints_show_parameter_name = true,
        inlay_hints_show_builtin = true,
        inlay_hints_exclude_single_argument = true,
        inlay_hints_hide_redundant_param_names = true,
        inlay_hints_hide_redundant_param_names_last_token = true,
      },
    },
    capabilities = options.capabilities,
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      options.on_attach_routine(client, bufnr)
    end
  }
end

return M
