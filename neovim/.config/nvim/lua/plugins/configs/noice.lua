return {
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    notify = {
      level = '3',
    },
    presets = {
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    cmdline = {
      format = {
        cmdline = {
          icon = ':',
        },
      },
    },
    views = {
      cmdline_popup = {
        border = {
          style = 'single',
        },
      },
      mini = {
        position = {
          row = '5%',
          col = '99%',
        },
      },
    },
  },
}
