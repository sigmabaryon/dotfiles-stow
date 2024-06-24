return {
  'anuvyklack/windows.nvim',
  -- cmd = {
  --   'WindowsMaximize',
  --   'WindowsMaximizeVertically',
  --   'WindowsMaximizeHorizontally',
  --   'WindowsEqualize',
  --   'WindowsEnableAutowidth',
  --   'WindowsDisableAutowidth',
  --   'WindowsToggleAutowidth',
  -- },
  dependencies = 'anuvyklack/middleclass',
  config = function()
    require('windows').setup({
      autowidth = {
        enable = true,
      },
    })
  end,
}
