require("aerial").setup({
  -- `aerial.nvim`'s treesitter backend is currently tripping over Neovim 0.12's
  -- parser/query API shape, so prefer the stable backends for now.
  backends = { "lsp", "markdown", "asciidoc", "man" },
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>fa", "<cmd>AerialToggle!<CR>")
