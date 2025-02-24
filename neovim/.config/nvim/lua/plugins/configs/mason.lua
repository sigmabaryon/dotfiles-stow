return {
  opts = {
    ensure_installed = {
      'efm',
      'lua-language-server',
      'stylua',
      'bash-language-server',
      'shellcheck',
      -- 'shellharden',
      'shfmt',
      -- 'prettier',
      -- 'black',
      'gopls',
      'goimports',
      'golangci-lint',
    },
    max_concurrent_installers = 5,
  },
  config = function(_, opts)
    require('mason').setup(opts)

    -- ref: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/plugins/init.lua#L58
    vim.api.nvim_create_user_command('MasonInstallAll', function()
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        vim.cmd('Mason')
        local mr = require('mason-registry')

        mr.refresh(function()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then p:install() end
          end
        end)
      end
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end,
}
