local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
    { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Find Symbols" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fn', builtin.grep_string, {})

local actions = require "telescope.actions"

require('telescope').setup {
    defaults = {
        path_display = { "truncate" },
        mappings = {
            n = {
                ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            i = {
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
                ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-d>d"] = actions.delete_buffer,
            }
        },
    },
}

require("telescope").load_extension("live_grep_args")

require('telescope').load_extension('fzf')
