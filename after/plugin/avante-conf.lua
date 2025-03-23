require('avante').setup({

  auto_suggestions_provider = "claude",
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-7-sonnet-20250219",
    temperature = 0,
    max_tokens = 4096,
  },
  mappings = {
    suggestion = {
      accept = "<Tab>",
      next = "<C-l>",
      prev = "<C-h>",
    }
  }
})
