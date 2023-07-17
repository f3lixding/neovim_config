require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  }
})

vim.keymap.set("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>u", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>ne", "<cmd>lua require('harpoon.ui').nav_next()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>nw", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", {noremap=true})

vim.keymap.set("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", {noremap=true})
vim.keymap.set("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", {noremap=true})
vim.keymap.set("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", {noremap=true})
vim.keymap.set("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", {noremap=true})
