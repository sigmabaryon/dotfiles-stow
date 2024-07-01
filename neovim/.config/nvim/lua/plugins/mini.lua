local MiniP = {}

function MiniP:simple()
  require('mini.align').setup()
  require('mini.animate').setup({
    resize = {
      timing = require('mini.animate').gen_timing.linear({ duration = 50, unit = 'total' }),
    },
  })
  require('mini.bracketed').setup({
    file = { suffix = '' },
    oldfile = { suffix = '' },
  })
  require('mini.bufremove').setup()
  require('mini.cursorword').setup()
  require('mini.extra').setup()
  require('mini.indentscope').setup()
  require('mini.jump').setup()
  require('mini.move').setup({ options = { reindent_linewise = false } })
  require('mini.operators').setup()
  require('mini.splitjoin').setup()
  require('mini.tabline').setup()
  require('mini.trailspace').setup()
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
    silent = true,
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
  local minifiles = require('mini.files')
  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local new_target_window
      vim.api.nvim_win_call(minifiles.get_target_window(), function()
        vim.cmd(direction .. ' split')
        new_target_window = vim.api.nvim_get_current_win()
      end)

      minifiles.set_target_window(new_target_window)
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      map_split(buf_id, [[<C-x>]], 'belowright horizontal')
      map_split(buf_id, [[<C-v>]], 'belowright vertical')
    end,
  })

  minifiles.setup({
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

function MiniP:statusline()
  local statusline = require('mini.statusline')

  local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
  local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)

  -- stylua: ignore start
  local modes = setmetatable({
    ['n']    = { sym = '##', hl = 'MiniStatuslineModeNormal'  },
    ['no']   = { sym = 'RO', hl = 'MiniStatuslineModeNormal'  },
    ['v']    = { sym = '**', hl = 'MiniStatuslineModeVisual'  },
    ['V']    = { sym = '*L', hl = 'MiniStatuslineModeVisual'  },
    [CTRL_V] = { sym = '*B', hl = 'MiniStatuslineModeVisual'  },
    ['s']    = { sym = 'S-', hl = 'MiniStatuslineMoodeVisual' },
    ['S']    = { sym = 'SL', hl = 'MiniStatuslineModeVisual'  },
    [CTRL_S] = { sym = 'SB', hl = 'MiniStatuslineModeVisual'  },
    ['i']    = { sym = 'IN', hl = 'MiniStatuslineModeInsert'  },
    ['ic']   = { sym = 'IC', hl = 'MiniStatuslineModeInsert'  },
    ['R']    = { sym = 'R-', hl = 'MiniStatuslineModeReplace' },
    ['Rv']   = { sym = 'RV', hl = 'MiniStatuslineModeReplace' },
    ['c']    = { sym = 'vX', hl = 'MiniStatuslineModeCommand' },
    ['ce']   = { sym = 'EX', hl = 'MiniStatuslineModeCommand' },
    ['r']    = { sym = 'PR', hl = 'MiniStatuslineModeOther'   },
    ['rm']   = { sym = 'PR', hl = 'MiniStatuslineModeOther'   },
    ['r?']   = { sym = 'PR', hl = 'MiniStatuslineModeOther'   },
    ['!']    = { sym = '$!', hl = 'MiniStatuslineModeOther'   },
    ['t']    = { sym = 'TT', hl = 'MiniStatuslineModeOther'   },
  }, {
    __index = function() return { long = '-?', short = '-?', hl = '%#MiniStatuslineModeOther#' } end,
  })

  local section_mode = function()
    local mode_info = modes[vim.fn.mode()]
    return mode_info.sym, mode_info.hl
  end

  local section_lsp = function()
        if rawget(vim, 'lsp') then return '󱅃' end
        return ''
  end

  local content_active = function()
    local mode, mode_hl = section_mode()
    local git         = statusline.section_git({ icon = '󰘬', trunc_width = 40 })
    local diagnostics = statusline.section_diagnostics({ icon = '', trunc_width = 75 })
    local lsp         = section_lsp()
    local filename    = '%t'
    local fileinfo    = vim.bo.filetype
    local location    = '%l:%v'

    return statusline.combine_groups({
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineFile', strings = { filename } },
      { hl = 'MiniStatuslineGeneral', strings = { git } },
      '%<', -- Mark general truncate point
      '%=', -- End left alignment
      { hl = 'DiagnosticOk', strings = { lsp } },
      { hl = 'MiniStatuslineGeneral', strings = { diagnostics } },
      { hl = 'MiniStatuslineGeneral', strings = { fileinfo } },
      { hl = 'MiniStatuslineGeneral', strings = { location } },
    })
  end

  require('mini.statusline').setup({
    content = {
      active = content_active,
      inactive = function() return '%<%=%#MiniStatuslineInactive#%F' end,
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
  self:basics()
  self:clue()
  self:files()
  -- self:hipatterns()
  self:misc()
  self:statusline()
  -- self:surround()
end

function MiniP:lazy_spec()
  return {
    {
      'echasnovski/mini.nvim',
      version = false,
      config = function() self:setup() end,
      dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
      },
    },
    {
      'echasnovski/mini.ai',
      version = false,
      event = { 'VeryLazy' },
      config = function()
        local ai = require('mini.ai')
        ai.setup({
          custom_textobjects = {
            B = require('mini.extra').gen_ai_spec.buffer(),
            F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
            C = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
            P = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
          },
        })
      end,
      dependencies = {
        {
          'nvim-treesitter/nvim-treesitter-textobjects',
          event = 'VeryLazy',
          config = function()
            require('nvim-treesitter.configs').setup({
              textobjects = {
                move = {
                  enable = true,
                  set_jumps = true,
                  goto_next_start = {
                    [']f'] = '@function.outer',
                    [']o'] = '@loop.*',
                    [']z'] = '@fold',
                    [']d'] = '@conditional.outer',
                  },
                  goto_previous_start = {
                    ['[f'] = '@function.outer',
                    ['[o'] = '@loop.*',
                    ['[z'] = '@fold',
                    ['[d'] = '@conditional.outer',
                  },
                },
              },
            })
            local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
            vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)
          end,
          -- dependencies = 'nvim-treesitter/nvim-treesitter',
        },
      },
    },
    {
      'echasnovski/mini-git',
      version = false,
      event = { 'VeryLazy' },
      config = function() require('mini.git').setup() end,
    },
    {
      'echasnovski/mini.diff',
      version = false,
      event = { 'VeryLazy' },
      config = function()
        local minidiff = require('mini.diff')
        minidiff.setup()
        local rhs = function() return minidiff.operator('yank') .. 'gh' end
        vim.keymap.set('n', 'ghy', rhs, { expr = true, remap = true, desc = "Copy hunk's reference lines" })
      end,
    },
    {
      'echasnovski/mini.jump',
      version = false,
      event = 'VeryLazy',
    },
    {
      'echasnovski/mini.jump2d',
      version = false,
      event = 'VeryLazy',
      config = function()
        local jump2d = require('mini.jump2d')
        local jump_line_start = jump2d.builtin_opts.line_start
        jump2d.setup({
          spotter = jump_line_start.spotter,
          hooks = { after_jump = jump_line_start.hooks.after_jump },
        })
      end,
    },
    {
      'echasnovski/mini.surround',
      version = false,
      event = 'VeryLazy',
      config = function()
        require('mini.surround').setup({ search_method = 'cover_or_next' })
        -- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
        vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
      end,
    },
  }
end

return MiniP:lazy_spec()
