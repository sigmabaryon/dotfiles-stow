local MiniP = {}

function MiniP:simple()
  require('mini.align').setup()
  require('mini.animate').setup({
    resize = {
      timing = require('mini.animate').gen_timing.cubic({ easing = 'in', duration = 2 }),
    },
  })
  require('mini.bracketed').setup()
  require('mini.bufremove').setup()
  require('mini.cursorword').setup()
  require('mini.extra').setup()
  require('mini.indentscope').setup()
  require('mini.jump').setup()
  require('mini.jump2d').setup({ view = { dim = true } })
  require('mini.move').setup({ options = { reindent_linewise = false } })
  require('mini.operators').setup()
  require('mini.splitjoin').setup()
  require('mini.tabline').setup()
  require('mini.trailspace').setup()
end

function MiniP:ai()
  local ai = require('mini.ai')
  ai.setup({
    custom_textobjects = {
      B = require('mini.extra').gen_ai_spec.buffer(),
      F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    },
  })
end

function MiniP:basics()
  require('mini.basics').setup({
    options = {
      basic = true,
      extra_ui = true,
      win_borders = 'single',
    },
    mappings = {
      basic = true,
      windows = false,
      move_with_alt = true,
    },
    autocommands = {
      basic = true,
      relnum_in_visual_mode = true,
    },
    silent = false,
  })
end

function MiniP:clue()
  local miniclue = require('mini.clue')
  local config = require('config')
  miniclue.setup({
    clues = {
      config.clue_leader_groups,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = config.clue_triggers,
  })
end

function MiniP:files()
  require('mini.files').setup({
    options = { permanent_delete = false },
    windows = { preview = true },
  })
end

function MiniP:hipatterns()
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end

function MiniP:misc()
  local minimisc = require('mini.misc')
  minimisc.setup({ make_global = { 'put', 'put_text', 'stat_summary', 'bench_time' } })
  minimisc.setup_auto_root()
end

function MiniP:notify()
  local mininotify = require('mini.notify')
  local filterout_lua_diagnosing = function(notif_arr)
    local not_diagnosing = function(notif) return not vim.startswith(notif.msg, 'lua_ls: Diagnosing') end
    notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
    return mininotify.default_sort(notif_arr)
  end
  mininotify.setup({
    content = { sort = filterout_lua_diagnosing },
  })
  vim.notify = mininotify.make_notify()
end

function MiniP:statusline()
  local statusline = require('mini.statusline')

  local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
  local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)

  local modes = setmetatable({
    ['n'] = { sym = '##', hl = 'MiniStatuslineModeNormal' },
    ['no'] = { sym = 'RO', hl = 'MiniStatuslineModeNormal' },
    ['v'] = { sym = '**', hl = 'MiniStatuslineModeVisual' },
    ['V'] = { sym = '*L', hl = 'MiniStatuslineModeVisual' },
    [CTRL_V] = { sym = '*B', hl = 'MiniStatuslineModeVisual' },
    ['s'] = { sym = 'S', hl = 'MiniStatuslineModeVisual' },
    ['S'] = { sym = 'SL', hl = 'MiniStatuslineModeVisual' },
    [CTRL_S] = { sym = 'SB', hl = 'MiniStatuslineModeVisual' },
    ['i'] = { sym = 'IN', hl = 'MiniStatuslineModeInsert' },
    ['ic'] = { sym = 'IC', hl = 'MiniStatuslineModeInsert' },
    ['R'] = { sym = 'R-', hl = 'MiniStatuslineModeReplace' },
    ['Rv'] = { sym = 'RV', hl = 'MiniStatuslineModeReplace' },
    ['c'] = { sym = 'vX', hl = 'MiniStatuslineModeCommand' },
    ['ce'] = { sym = 'EX', hl = 'MiniStatuslineModeCommand' },
    ['r'] = { sym = 'PR', hl = 'MiniStatuslineModeOther' },
    ['rm'] = { sym = 'PR', hl = 'MiniStatuslineModeOther' },
    ['r?'] = { sym = 'PR', hl = 'MiniStatuslineModeOther' },
    ['!'] = { sym = '$!', hl = 'MiniStatuslineModeOther' },
    ['t'] = { sym = 'TT', hl = 'MiniStatuslineModeOther' },
  }, {
    -- By default return 'Unknown' but this shouldn't be needed
    __index = function() return { long = '-?', short = '-?', hl = '%#MiniStatuslineModeOther#' } end,
  })

  local section_mode = function()
    local mode_info = modes[vim.fn.mode()]
    return mode_info.sym, mode_info.hl
  end

  local content_active = function()
    local mode, mode_hl = section_mode()
    local git = statusline.section_git({ trunc_width = 40 })
    local diff = statusline.section_diff({ trunc_width = 75 })
    local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
    local lsp = statusline.section_lsp({ trunc_width = 75 })
    local filename = statusline.section_filename({ trunc_width = 140 })
    local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
    local location = statusline.section_location({ trunc_width = 75 })
    local search = statusline.section_searchcount({ trunc_width = 75 })
    -- H.use_icons = nil

    -- Usage of `statusline.combine_groups()` ensures highlighting and
    -- correct padding with spaces between groups (accounts for 'missing'
    -- sections, etc.)
    return statusline.combine_groups({
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl, strings = { search, location } },
    })
  end

  local content_inactive = function()
    local filename = statusline.section_filename({ trunc_width = 140 })
    return statusline.combine_groups({
      '%<',
      '%=',
      { hl = 'MiniStatuslineInactive', strings = { filename } },
    })
  end

  require('mini.statusline').setup({
    content = {
      active = content_active,
      inactive = content_inactive,
    },
  })
end

function MiniP:surround()
  require('mini.surround').setup({ search_method = 'cover_or_next' })
  -- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
  vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
end

function MiniP:setup()
  self:simple()
  self:ai()
  self:basics()
  self:clue()
  self:files()
  self:hipatterns()
  self:misc()
  self:notify()
  self:statusline()
  self:surround()
end

function MiniP:lazy_spec()
  return {
    {
      'echasnovski/mini.nvim',
      version = false,
      config = function() self:setup() end,
      dependencies = {
        {
          'nvim-treesitter/nvim-treesitter-textobjects',
          event = 'VeryLazy',
          dependencies = 'nvim-treesitter/nvim-treesitter',
        },
        { 'nvim-tree/nvim-web-devicons' },
      },
    },
    {
      'echasnovski/mini-git',
      version = false,
      event = { 'BufReadPost' },
      config = function() require('mini.git').setup() end,
    },
    {
      'echasnovski/mini.diff',
      version = false,
      event = { 'BufReadPost' },
      config = function()
        local minidiff = require('mini.diff')
        minidiff.setup()
        local rhs = function() return minidiff.operator('yank') .. 'gh' end
        vim.keymap.set('n', 'ghy', rhs, { expr = true, remap = true, desc = "Copy hunk's reference lines" })
      end,
    },
  }
end

return MiniP:lazy_spec()
