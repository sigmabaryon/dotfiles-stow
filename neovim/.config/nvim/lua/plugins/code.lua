-- Code
-- - Formatting: conform
-- - General: gentags
-- - Binstaller: mason
-- - LSP
-- - treesitter
-- - DAP
return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    config = require('plugins.configs.treesitter').config,
  },
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
    opts = require('plugins.configs.mason').opts,
    config = require('plugins.configs.mason').config,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    config = require('plugins.configs.lspconfig').config,
  },
  -- TODO: replace with none-ls (also supports linting)
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>lf',
        function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = require('plugins.configs.formatters').opts,
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
  },
  {
    'JMarkin/gentags.lua',
    cond = vim.fn.executable('ctags') == 1,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = true,
    event = 'VeryLazy',
  },
  {
    'liuchengxu/vista.vim',
    cmd = 'Vista',
    config = function() vim.g.vista_default_executive = 'ctags' end,
  },
  {
    'stevearc/aerial.nvim',
    lazy = true,
    opts = require('plugins.configs.aerial').opts,
    event = 'LspAttach',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  -- {
  --   'mfussenegger/nvim-dap',
  --   lazy = true,
  --   cmd = {
  --     'DapSetLogLevel',
  --     'DapShowLog',
  --     'DapContinue',
  --     'DapToggleBreakpoint',
  --     'DapToggleRepl',
  --     'DapStepOver',
  --     'DapStepInto',
  --     'DapStepOut',
  --     'DapTerminate',
  --   },
  --   config = require('tool.dap'),
  --   dependencies = {
  --     {
  --       'rcarriga/nvim-dap-ui',
  --       config = require('tool.dap.dapui'),
  --       dependencies = {
  --         'nvim-neotest/nvim-nio',
  --       },
  --     },
  --     { 'jay-babu/mason-nvim-dap.nvim' },
  --   },
  -- },
}
