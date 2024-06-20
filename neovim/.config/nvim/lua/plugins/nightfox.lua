return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local hipattern_style = 'bold,standout,underline'
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
          MiniHipatternsFixme = { style = hipattern_style, bg = 'palette.red', fg = 'palette.bg0' },
          MiniHipatternsHack = { style = hipattern_style, bg = 'palette.yellow', fg = 'palette.bg0' },
          MiniHipatternsTodo = { style = hipattern_style, bg = 'palette.orange', fg = 'palette.bg0' },
          MiniHipatternsNote = { style = hipattern_style, bg = 'palette.green', fg = 'palette.bg0' },
          MiniHipatternsRef = { style = hipattern_style, bg = 'palette.blue', fg = 'palette.bg0' },
        },
      },
    })
    vim.cmd('set termguicolors')
    vim.cmd('colorscheme nightfox')
  end,
}
