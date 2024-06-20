local MiniP = {}

function MiniP:simple()
  require('mini.align').setup()
  require('mini.animate').setup()
  require('mini.bracketed').setup()
  require('mini.bufremove').setup()
  require('mini.cursorword').setup()
  require('mini.extra').setup()
  require('mini.git').setup()
  require('mini.indentscope').setup()
  require('mini.jump').setup()
  require('mini.jump2d').setup({ view = { dim = true } })
  require('mini.move').setup({ options = { reindent_linewise = false } })
  require('mini.operators').setup()
  require('mini.splitjoin').setup()
  require('mini.statusline').setup()
  require('mini.tabline').setup()
  require('mini.trailspace').setup()
  -- require('mini.visits').setup()
end

function MiniP:ai()
  local ai = require('mini.ai')
  ai.setup({
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
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
  --stylua: ignore
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
    -- window = { config = { border = 'double' } },
  })
end

function MiniP:diff()
  require('mini.diff').setup()
  local rhs = function() return MiniDiff.operator('yank') .. 'gh' end
  vim.keymap.set('n', 'ghy', rhs, { expr = true, remap = true, desc = "Copy hunk's reference lines" })
end

function MiniP:files()
  require('mini.files').setup({
    options = { permanent_delete = false },
    windows = { preview = true },
  })
end

function MiniP:hipatterns()
  local hipatterns = require('mini.hipatterns')
  -- local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      -- fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      -- hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      -- todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      -- note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end

function MiniP:misc()
  require('mini.misc').setup({ make_global = { 'put', 'put_text', 'stat_summary', 'bench_time' } })
  MiniMisc.setup_auto_root()
end

function MiniP:notify()
  local filterout_lua_diagnosing = function(notif_arr)
    local not_diagnosing = function(notif) return not vim.startswith(notif.msg, 'lua_ls: Diagnosing') end
    notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
    return MiniNotify.default_sort(notif_arr)
  end
  require('mini.notify').setup({
    content = { sort = filterout_lua_diagnosing },
  })
  vim.notify = MiniNotify.make_notify()
end

function MiniP:pick()
  local win_config = function()
    local height = math.floor(0.45 * vim.o.lines)
    local width = vim.o.columns
    return {
      anchor = 'NW',
      height = height,
      width = width,
      row = (vim.o.lines - height),
      col = (vim.o.columns - width),
    }
  end

  require('mini.pick').setup({
    window = {
      config = win_config,
    },
    content_from_bottom = true,
  })
  vim.ui.select = MiniPick.ui_select
  vim.keymap.set('n', ',', [[<Cmd>Pick buf_lines scope='current'<CR>]], { nowait = true })
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
  self:diff()
  self:files()
  -- self:hipatterns()
  self:misc()
  self:notify()
  -- self:pick()
  self:surround()
end

function MiniP:lazy_spec()
  return {
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
  }
end

return MiniP:lazy_spec()
