-- UI
-- colorscheme: nightfox
-- quickfix: bqf
-- best practices: hardtime
-- general ui: noice
-- windows: smart-splits, windows, windoe-picker
-- todo-comments
return {
  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    ft = 'qf',
    opts = {
      preview = {
        border = 'single',
        wrap = true,
        winblend = 0,
      },
    },
    dependencies = {
      { 'junegunn/fzf', build = ':call fzf#install()' },
    },
  },
  -- {
  --   'm4xshen/hardtime.nvim',
  --   dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  --   opts = {
  --     max_time = 2000,
  --     max_count = 5,
  --   },
  --   -- cmd = { 'Hardtime' },
  -- },
  -- {
  --   'EdenEast/nightfox.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = require('plugins.configs.nightfox').config,
  -- },
  {
    'echasnovski/mini.hues',
    lazy = false,
    priority = 1000,
    version = false,
    config = function()
      require('mini.hues').setup({
        background = '#1d1f21',
        foreground = '#c5c8c6',
      })
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = require('plugins.configs.noice').opts,
  },
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    event = 'VeryLazy',
    cmd = { 'NoNeckPain', 'NoNeckPainWidthUp', 'NoNeckPainWidthDown' },
    -- TODO: Add path for norg files in scratch buffers
    opts = {
      width = 125,
    },
  },
  {
    'yorickpeterse/nvim-window',
    keys = {
      { '<leader>wp', "<cmd>lua require('nvim-window').pick()<cr>", desc = 'nvim-window: Jump to window' },
    },
    config = true,
  },
  {
    'mrjones2014/smart-splits.nvim',
    lazy = true,
    event = 'BufReadPost',
    build = './kitty/install-kittens.bash',
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = require('plugins.configs.todo_comments').opts,
  },
  {
    'anuvyklack/windows.nvim',
    event = 'BufReadPost',
    cmd = {
      'WindowsMaximize',
      'WindowsMaximizeVertically',
      'WindowsMaximizeHorizontally',
      'WindowsEqualize',
      'WindowsEnableAutowidth',
      'WindowsDisableAutowidth',
      'WindowsToggleAutowidth',
    },
    dependencies = { 'anuvyklack/middleclass' },
    opts = {
      autowidth = {
        enable = true,
      },
      ignore = {
        buftype = { 'quickfix' },
        filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo', 'no-neck-pain' },
      },
    },
  },
}
