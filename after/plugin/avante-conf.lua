require('avante').setup({
  auto_suggestions_provider = "claude-haiku",
  providers = {
    ["codestral"] = {
      __inherited_from = 'openai',            -- Inherit from OpenAI-compatible provider
      endpoint = 'https://api.mistral.ai/v1', -- Mistral API endpoint
      api_key_name = 'CODESTRAL_API_KEY',     -- Your Codestral API key
      model = 'codestral-latest',             -- Codestral model
      extra_request_body = {
        max_tokens = 8192,
        temperature = 0,
      }
    },
    ["claude-haiku"] = {
      __inherited_from = "claude",
      model = "claude-3-5-haiku-20241022",
      timeout = 30000, -- Timeout in milliseconds
      extra_request_body = {
        max_tokens = 16384,
        temperature = 0,
      }
    },
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-20250514",
      extra_request_body = {
        max_tokens = 8192,
        temperature = 0,
      }
    },
  },
  mappings = {
    suggestion = {
      accept = "<Tab>",
      next = "<C-l>",
      prev = "<C-h>",
    }
  }
})
