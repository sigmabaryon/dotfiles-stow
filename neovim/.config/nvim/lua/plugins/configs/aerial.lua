return {
  opts = {
    lazy_load = false,
    close_on_select = true,
    highlight_on_jump = false,
    disable_max_lines = 8500,
    disable_max_size = 1000000,
    ignore = { filetypes = { 'terminal', 'nofile' } },
    manage_folds = 'auto',
    layout = {
      default_direction = 'prefer_right',
    },
    filter_kind = {
      'Array',
      'Boolean',
      'Class',
      'Constant',
      'Constructor',
      'Enum',
      'EnumMember',
      'Event',
      'Field',
      'File',
      'Function',
      'Interface',
      'Key',
      'Method',
      'Module',
      'Namespace',
      'Null',
      -- "Number",
      'Object',
      'Operator',
      'Package',
      'Property',
      -- "String",
      'Struct',
      -- "TypeParameter",
      -- "Variable",
    },
  },
}
