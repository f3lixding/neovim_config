local M = {}

function M.set_up(on_attach_routine)
  require("lspconfig").zls.setup {
    on_attach = function(_, bufnr)
      on_attach_routine(_, bufnr)
    end
  }
end

return M
