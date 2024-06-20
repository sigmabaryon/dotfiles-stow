local config = {
  clue_leader_groups = {
    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
    { mode = 'n', keys = '<Leader>f', desc = '+Find' },
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
    { mode = 'n', keys = '<Leader>o', desc = '+Other' },
    { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
    { mode = 'n', keys = '<Leader>W', desc = '+SplitSwap' },
  },
  clue_triggers = {
    { mode = 'n', keys = '<Leader>' }, -- Leader triggers
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = [[\]] }, -- mini.basics
    { mode = 'n', keys = '[' }, -- mini.bracketed
    { mode = 'n', keys = ']' },
    { mode = 'x', keys = '[' },
    { mode = 'x', keys = ']' },
    { mode = 'i', keys = '<C-x>' }, -- Built-in completion
    { mode = 'n', keys = 'g' }, -- `g` key
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" }, -- Marks
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },
    { mode = 'n', keys = '"' }, -- Registers
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' }, -- Window commands
    { mode = 'n', keys = 'z' }, -- `z` key
    { mode = 'x', keys = 'z' },
  },
}

return config
