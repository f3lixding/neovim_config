require('avante').setup({
  mappings = {
    suggestion = {
      insert = {
        accept = "<Tab>",
        next = "<C-l>",
        prev = "<C-h>",
        dismiss = "<C-[>"
      }
    }
  }
})
