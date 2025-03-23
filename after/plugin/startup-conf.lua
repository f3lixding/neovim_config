local startup = require("startup")

startup.setup({
  -- Every line should be same width without escaped \
  header = {
    type = "text",
    align = "center",
    fold_section = false,
    title = "Header",
    margin = 5,
    content = {
      '                                                                   ',
      '      ███████████           █████      ██                    ',
      '     ███████████             █████                            ',
      '     ████████████████ ███████████ ███   ███████    ',
      '    ████████████████ ████████████ █████ ██████████████  ',
      '   ██████████████    █████████████ █████ █████ ████ █████  ',
      ' ██████████████████████████████████ █████ █████ ████ █████ ',
      '██████  ███ █████████████████ ████ █████ █████ ████ ██████',
    },
    highlight = "Statement",
  },

  -- Name of the section
  body = {
    type = "mapping",
    align = "center",
    fold_section = false,
    title = "Basic Commands",
    margin = 5,
    content = {
      { " Find File",    "Telescope find_files",            "<leader>ff" },
      { " Find Word",    "Telescope live_grep",             "<leader>fg" },
    },
    highlight = "String",
    default_color = "",
    oldfiles_amount = 0,
  },

  footer = {
    type = "text",
    align = "center",
    fold_section = false,
    title = "Footer",
    margin = 5,
    content = { "Neovim " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch },
    highlight = "Number",
    default_color = "",
    oldfiles_amount = 0,
  },

  options = {
    mapping_keys = true,
    cursor_column = 0.5,
    empty_lines_between_mappings = true,
    disable_statuslines = true,
    paddings = { 8, 3, 3, 8 },
  },

  colors = {
    background = "#1f2227",
    folded_section = "#56b6c2",
  },

  parts = { "header", "body", "footer" },
})

-- Automatically close NvimTree if it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

-- Function to create a new file
local function new_file()
  vim.cmd('enew')
end

-- Export the new_file function
return {
  new_file = new_file,
}

