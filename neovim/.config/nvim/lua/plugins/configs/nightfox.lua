return {
  config = function()
    require('nightfox').setup({
      options = {
        dim_inactive = true,
        styles = {
          comments = 'italic',
          keywords = 'bold',
          types = 'bold,italic',
        },
      },
      groups = {
        all = {
          MiniCursorword = { style = 'underline', sp = 'palette.fg3' },
          MiniCursorwordCurrent = { style = 'underline', sp = 'palette.fg3' },
          MiniStatuslineInactive = { fg = 'palette.fg0', bg = 'palette.bg0' },
          MiniStatuslineGeneral = { fg = 'palette.fg3', bg = 'palette.bg1' },
          MiniStatuslineFile = { fg = 'palette.fg2', bg = 'palette.bg1' },
        },
      },
    })
    vim.cmd('set termguicolors')
    vim.cmd('colorscheme nightfox')
  end,
}
