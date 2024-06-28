return {
  config = function()
    require('toggleterm').setup({
      shell = '/usr/bin/fish',
    })
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })

    Equip._lazygit_toggle = function() lazygit:toggle() end

    vim.api.nvim_set_keymap(
      'n',
      '<leader>gg',
      '<cmd>lua Equip._lazygit_toggle()<CR>',
      { noremap = true, silent = true }
    )
  end,
}
