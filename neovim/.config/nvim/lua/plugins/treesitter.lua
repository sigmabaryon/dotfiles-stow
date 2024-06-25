local TSitter = {
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
}

function TSitter:setup()
  require('nvim-treesitter.configs').setup({
    ensure_installed = self.ensure_installed,
    highlight = {
      enable = true,
      -- disable = function(_, buf)
      --   local max_filesize = 100 * 1024 -- 100 KB
      --   local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      --   if ok and stats and stats.size > max_filesize then return true end
      -- end,
    },
    incremental_selection = { enable = false },
    textobjects = { enable = false },
    indent = { enable = false },
  })

  local ts_query = require('vim.treesitter.query')
  local ts_query_set = ts_query.set or ts_query.set_query
  ts_query_set('lua', 'injections', '')
end

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  build = ':TSUpdate',
  config = function() TSitter:setup() end,
}
