return {
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
      -- python = { 'isort', 'black' },
      -- javascript = { { 'prettierd', 'prettier' } },
    },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
}
