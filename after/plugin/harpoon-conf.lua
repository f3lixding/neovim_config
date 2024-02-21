require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 40,
    tabline = false,
    tabline_prefix = "  ",
    tabline_suffix = "  "
  }
})

vim.keymap.set("n", "<leader>mm", "<cmd>lua require('harpoon.mark').add_file()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>uu", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>ii", "<cmd>lua require('harpoon.ui').nav_next()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>oo", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", {noremap=true})

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, "<cmd>lua require('harpoon.ui').nav_file(" .. i .. ")<CR>", {noremap=true})
end

require('telescope').load_extension('harpoon')

vim.keymap.set("n", "<leader>fm", "<cmd>Telescope harpoon marks<CR>", {noremap=true})
