return {
  opts = {
    log_level = vim.log.levels.ERROR,
    auto_session_suppress_dirs = { '~/.local' },
    auto_session_use_git_branch = true,
    auto_session_enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= 'true',

    auto_session_enable_last_session = false,

    session_lens = {
      buftypes_to_ignore = {},
      load_on_setup = false,
      theme_conf = { border = false },
      previewer = false,
    },
  },
  config = function(_, opts) require('auto-session').setup(opts) end,
}
