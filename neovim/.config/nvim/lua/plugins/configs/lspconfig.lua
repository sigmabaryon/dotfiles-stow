return {
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local diagnostic_opts = {
      float = { border = 'single' },
      -- Show gutter sings
      signs = {
        -- With highest priority
        priority = 9999,
        -- Only for warnings and errors
        severity = { min = 'WARN', max = 'ERROR' },
      },
      -- Show virtual text only for errors
      virtual_text = { severity = { min = 'ERROR', max = 'ERROR' } },
      -- Don't update diagnostics when typing
      update_in_insert = false,
    }

    vim.diagnostic.config(diagnostic_opts)

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim' },
            -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
            workspaceDelay = -1,
          },
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
            ignoreSubmodules = true,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    lspconfig.bashls.setup({
      capabilities = capabilities,
      single_file_support = true,
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
    })

  end,
}
