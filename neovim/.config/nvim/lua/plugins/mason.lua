local Msn = {
  ensure_installed = {
    'lua-language-server',
    'stylua',
    -- 'prettier',
    -- 'black',
  },
}

function Msn:ensure()
  -- ref: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/plugins/init.lua#L58
  vim.api.nvim_create_user_command('MasonInstallAll', function()
    if self.ensure_installed and #self.ensure_installed > 0 then
      vim.cmd('Mason')
      local mr = require('mason-registry')

      mr.refresh(function()
        for _, tool in ipairs(self.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end)
    end
  end, {})
end

return {
  'williamboman/mason.nvim',
  cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
  config = function()
    require('mason').setup({ max_concurrent_installers = 5 })
    Msn:ensure()
    vim.g.mason_binaries_list = Msn.ensure_installed
  end,
}
