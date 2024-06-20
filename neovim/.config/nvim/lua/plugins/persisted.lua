return {
  'olimorris/persisted.nvim',
  lazy = true,
  cmd = {
    'SessionToggle',
    'SessionStart',
    'SessionStop',
    'SessionSave',
    'SessionLoad',
    'SessionLoadLast',
    'SessionLoadFromFile',
    'SessionDelete',
  },
  opts = {
    use_git_branch = true,
    -- should_autosave = function()
    --   if vim.bo.filetype == 'alpha' then return false end
    --   return true
    -- end,
    allowed_dirs = {
      '~/projects',
    },
    telescope = {
      mappings = {
        change_branch = '<c-b>',
        copy_session = '<c-c>',
        delete_session = '<c-d>',
      },
    },
  },
}
