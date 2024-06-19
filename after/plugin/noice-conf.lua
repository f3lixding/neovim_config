require("noice").setup({
  presets = {
    -- you can enable a preset by setting it to true, or a table that will override the preset config
    -- you can also add custom presets that you can enable/disable with enabled=true
    bottom_search = false,        -- use a classic bottom cmdline for search
    command_palette = true,      -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = true,            -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
  },
  cmdline_popupmenu = {
    relative = "editor",
    position = {
      row = 13,
      col = "50%",
    },
    size = {
      width = 60,
      height = "auto",
      max_height = 15,
    },
    border = {
      style = "rounded",
      padding = { 0, 3 },
    },
  },
})

require('notify').setup({
  background_colour = "#000000",
})
