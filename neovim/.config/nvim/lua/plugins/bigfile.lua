local ftdetect = {
  name = 'ftdetect',
  opts = { defer = true },
  disable = function() vim.api.nvim_set_option_value('filetype', 'big_file_disabled_ft', { scope = 'local' }) end,
}

local cmp = {
  name = 'nvim-cmp',
  opts = { defer = true },
  disable = function() require('cmp').setup.buffer({ enabled = false }) end,
}

local cursorword = {
  name = 'mini.cursorword',
  opts = { defer = true },
  disable = function() vim.b.minicursorword_disable = true end,
}

local trailspace = {
  name = 'mini.trailspace',
  opts = { defer = true },
  disable = function() vim.b.minitrailspace_disable = true end,
}

local indentscope = {
  name = 'mini.indentscope',
  opts = { defer = true },
  disable = function() vim.b.miniindentscope_disable = true end,
}

return {
  'LunarVim/bigfile.nvim',
  lazy = false,
  opts = {
    filesize = 1, -- size of the file in MiB
    pattern = { '*' }, -- autocmd pattern
    features = {
      'lsp',
      'treesitter',
      'syntax',
      'vimopts',
      ftdetect,
      cmp,
      cursorword,
      trailspace,
      indentscope,
    },
  },
}
