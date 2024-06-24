local setup = function()
  local lga_actions = require('telescope-live-grep-args.actions')

  local opts = {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
      },
      initial_mode = 'insert',
      scroll_strategy = 'limit',
      results_title = '',
      layout_strategy = 'vertical',
      path_display = { 'truncate' },
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      file_ignore_patterns = { '%.git/', '%.cache', 'build/', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip' },
      dynamic_preview_title = true,
      prompt_prefix = ' >>> ',
      selection_caret = '',
      entry_prefix = '',
      multi_icon = '',
      preview = { msg_bg_fillchar = ' ' },
      borderchars = {
        { '-', '', '-', '', '-', '-', '-', '-' },
        prompt = { '-', '', '-', '', '-', '-', '-', '-' },
        results = { '-', '', '-', '', '-', '-', '-', '-' },
        preview = { '-', '', '-', '', '-', '-', '-', '-' },
      },
      layout_config = {
        prompt_position = 'bottom',
        anchor = 'S',
        width = function(_, max_columns, _) return max_columns end,
        height = function(_, _, max_lines) return math.ceil(max_lines / 2) end,
      },
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    },
    extensions = {
      aerial = {
        show_lines = false,
        show_nesting = {
          ['_'] = false, -- This key will be the default
          lua = true, -- You can set the option for specific filetypes
        },
      },
      fzf = {
        fuzzy = false,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
      frecency = {
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { '*.git/*', '*/tmp/*' },
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ['<C-k>'] = lga_actions.quote_prompt(),
            ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
          },
        },
      },
      undo = {
        side_by_side = true,
        mappings = { -- this whole table is the default
          i = {
            -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
            -- you want to use the following actions. This means installing as a dependency of
            -- telescope in it's `requirements` and loading this extension from there instead of
            -- having the separate plugin definition as outlined above. See issue #6.
            ['<cr>'] = require('telescope-undo.actions').yank_additions,
            ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
            ['<C-cr>'] = require('telescope-undo.actions').restore,
          },
        },
      },
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }
  require('telescope').setup(opts)
  require('telescope').load_extension('frecency')
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('live_grep_args')
  -- require('telescope').load_extension('notify')
  -- require('telescope').load_extension('projects')
  require('telescope').load_extension('undo')
  require('telescope').load_extension('zoxide')
  require('telescope').load_extension('persisted')
  require('telescope').load_extension('aerial')
  require('telescope').load_extension('ui-select')
end

return {
  'nvim-telescope/telescope.nvim',
  -- enabled = false,
  lazy = true,
  cmd = 'Telescope',
  config = setup,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lua/plenary.nvim' },
    { 'debugloop/telescope-undo.nvim' },
    -- {
    --   'ahmedkhalf/project.nvim',
    --   event = { 'CursorHold', 'CursorHoldI' },
    --   config = require('tool.project'),
    -- },
    { 'jvgrootveld/telescope-zoxide' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'stevearc/aerial.nvim' },
  },
}
