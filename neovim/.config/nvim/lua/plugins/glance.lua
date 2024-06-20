return {
  'dnlhc/glance.nvim',
  enabled = false,
  event = 'LspAttach',
  config = function() require('glance').setup({}) end,
}
