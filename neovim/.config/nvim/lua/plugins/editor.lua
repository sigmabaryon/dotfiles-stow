-- Editor tools
-- - Auto Session
-- - Bigfile feature disabling
-- - Sepctre, search and replace
-- - ToggleTerm
return {
  {
    'rmagatti/auto-session',
    opts = require('plugins.configs.auto_session').opts,
    config = require('plugins.configs.auto_session').config,
  },
  {
    'LunarVim/bigfile.nvim',
    lazy = false,
    opts = require('plugins.configs.bigfile').opts,
  },
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function() require('kitty-scrollback').setup() end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = require('plugins.configs.cmp').config,
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        opts = {
          history = true,
          updateevents = 'TextChanged,TextChangedI',
          delete_check_events = 'TextChanged,InsertLeave',
        },
        config = function(_, opts)
          require('luasnip').config.set_config(opts)
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
        dependencies = 'rafamadriz/friendly-snippets',
      },

      {
        'windwp/nvim-autopairs',
        opts = {
          fast_wrap = {},
          disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        config = function(_, opts)
          require('nvim-autopairs').setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require('nvim-autopairs.completion.cmp')
          require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
      },

      -- sources
      {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'ray-x/cmp-treesitter',
        'f3fora/cmp-spell',
        'lukas-reineke/cmp-under-comparator',
      },

      { 'neovim/nvim-lspconfig' },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    lazy = true,
    cmd = 'Spectre',
  },
  {
    'lambdalisue/suda.vim',
    lazy = true,
    cmd = { 'SudaRead', 'SudaWrite' },
    init = function() vim.g['suda#prompt'] = '# Password: ' end,
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = 'Telescope',
    config = require('plugins.configs.telescope').config,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-lua/plenary.nvim' },
      { 'debugloop/telescope-undo.nvim' },
      { 'jvgrootveld/telescope-zoxide' },
      { 'nvim-telescope/telescope-frecency.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'stevearc/aerial.nvim' },
      { 'rmagatti/auto-session' },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'VeryLazy',
    config = require('plugins.configs.toggleterm').config,
  },
}
