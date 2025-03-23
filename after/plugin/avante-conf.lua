require('avante').setup({
  auto_suggestions_provider = "codestral",
  vendors = {
    ["codestral"] = {
      __inherited_from = 'openai',              -- Inherit from OpenAI-compatible provider
      endpoint = 'https://api.mistral.ai/v1',   -- Mistral API endpoint
      api_key_name = 'CODESTRAL_API_KEY',       -- Your Codestral API key
      model = 'codestral-latest',                      -- Codestral model
      temperature = 0,
      max_tokens = 4096,
    }
  },
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
