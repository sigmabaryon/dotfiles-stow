return {
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
      -- python = { 'isort', 'black' },
      -- javascript = { { 'prettierd', 'prettier' } },
      yaml = { 'prettier' },
      json = { 'prettier' },
      markdown = { 'prettier' },
      go = { 'gofmt', 'goimports' },
    },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
}
