return {
  -- TODO: revisit cmp setup
  config = function()
    local cmp = require('cmp')

    local compare = require('cmp.config.compare')
    compare.lsp_scores = function(entry1, entry2)
      local diff
      if entry1.completion_item.score and entry2.completion_item.score then
        diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
      else
        diff = entry2.score - entry1.score
      end
      return (diff < 0)
    end

    local comparators = {
      -- require("cmp_tabnine.compare"),
      compare.offset, -- Items closer to cursor will have lower priority
      compare.exact,
      -- compare.scopes,
      compare.lsp_scores,
      compare.sort_text,
      compare.score,
      compare.recently_used,
      -- compare.locality, -- Items closer to cursor will have higher priority, conflicts with `offset`
      require('cmp-under-comparator').under,
      compare.kind,
      compare.length,
      compare.order,
    }

    local opts = {
      preselect = cmp.PreselectMode.None,
      sorting = {
        priority_weight = 2,
        comparators = comparators,
      },
      matching = {
        disallow_partial_fuzzy_matching = false,
      },
      performance = {
        async_budget = 1,
        max_view_entries = 120,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-w>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require('luasnip').expand_or_locally_jumpable() then
            require('luasnip').expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
      },
      sources = {
        { name = 'nvim_lsp', max_item_count = 350 },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'treesitter' },
        { name = 'spell' },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
          },
        },
        -- { name = "latex_symbols" },
        -- { name = "copilot" },
        -- { name = "codeium" },
        -- { name = "cmp_tabnine" },
      },
      experimental = {
        ghost_text = {
          hl_group = 'Comment',
        },
      },
    }

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'buffer' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })

    cmp.setup(opts)
  end,
}
