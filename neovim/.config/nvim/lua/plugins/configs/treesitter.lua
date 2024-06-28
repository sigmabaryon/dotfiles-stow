return {
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        'c',
        'fish',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'rst',
        'rust',
        'toml',
        'yaml',
        'vim',
        'vimdoc',
      },
      highlight = {
        enable = true,
      },
      incremental_selection = { enable = false },
      textobjects = { enable = false },
      indent = { enable = false },
    })

    local ts_query = require('vim.treesitter.query')
    local ts_query_set = ts_query.set or ts_query.set_query
    ts_query_set('lua', 'injections', '')
  end,
}
