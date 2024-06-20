return {
  'kevinhwang91/nvim-bqf',
  lazy = true,
  ft = 'qf',
  opts = {
    preview = {
      border = 'single',
      wrap = true,
      winblend = 0,
    },
  },
  dependencies = {
    { 'junegunn/fzf', build = ':call fzf#install()' },
  },
}
