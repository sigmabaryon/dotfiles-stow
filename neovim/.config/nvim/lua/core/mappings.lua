local keymap = function(mode, keys, cmd, opts)
  opts = opts or {}
  if opts.silent == nil then opts.silent = true end
  vim.keymap.set(mode, keys, cmd, opts)
end

-- Terminal
-- keymap('t', [[<C-h>]], [[<C-\><C-N><C-w>h]])
keymap('t', [[<Esc><Esc>]], [[<C-\><C-N>]])

-- Delete selection in Select mode (helpful when editing snippet placeholders)
keymap('s', [[<BS>]], [[<BS>i]])

-- Better command history navigation
keymap('c', '<C-p>', '<Up>', { silent = false })
keymap('c', '<C-n>', '<Down>', { silent = false })

-- Stop highlighting of search results.
-- NOTE: this can be done with default `<C-l>` but this solution deliberately
-- uses `:` instead of `<Cmd>` to go into Command mode and back which updates 'mini.map'.
keymap('n', [[\h]], ':let v:hlsearch = 1 - v:hlsearch<CR>', { desc = 'Toggle hlsearch' })

-- Paste before/after linewise
keymap({ 'n', 'x' }, '[p', '<Cmd>exe "put! " . v:register<CR>', { desc = 'Paste Above' })
keymap({ 'n', 'x' }, ']p', '<Cmd>exe "put "  . v:register<CR>', { desc = 'Paste Below' })

-- Splits
keymap(
  'n',
  [[<A-h>]],
  '<Cmd>SmartResizeLeft<CR>',
  { desc = 'window: Resize -3 horizontally', noremap = true, silent = true }
)
keymap(
  'n',
  [[<A-j>]],
  '<Cmd>SmartResizeDown<CR>',
  { desc = 'window: Resize -3 vertically', noremap = true, silent = true }
)
keymap(
  'n',
  [[<A-k>]],
  '<Cmd>SmartResizeUp<CR>',
  { desc = 'window: Resize +3 vertically', noremap = true, silent = true }
)
keymap(
  'n',
  [[<A-l>]],
  '<Cmd>SmartResizeRight<CR>',
  { desc = 'window: Resize +3 horizontally', noremap = true, silent = true }
)
keymap('n', [[<C-h>]], '<Cmd>SmartCursorMoveLeft<CR>', { desc = 'window: Focus left', noremap = true, silent = true })
keymap('n', [[<C-j>]], '<Cmd>SmartCursorMoveDown<CR>', { desc = 'window: Focus down', noremap = true, silent = true })
keymap('n', [[<C-k>]], '<Cmd>SmartCursorMoveUp<CR>', { desc = 'window: Focus up', noremap = true, silent = true })
keymap('n', [[<C-l>]], '<Cmd>SmartCursorMoveRight<CR>', { desc = 'window: Focus right', noremap = true, silent = true })

local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end

local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

-- b is for 'buffer'
nmap_leader('ba', '<Cmd>b#<CR>', 'Alternate')
nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>', 'Delete')
nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>', 'Delete!')
nmap_leader('bs', '<Cmd>lua Equip.new_scratch_buffer()<CR>', 'Scratch')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>', 'Wipeout')
nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- e is for 'explore' and 'edit'
nmap_leader('ec', '<Cmd>lua MiniFiles.open("~/projects/dotfiles/neovim/.config/nvim")<CR>', 'Config')
nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>', 'Directory')
nmap_leader('ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')
-- TODO: check quickfix plugins
nmap_leader('eq', '<Cmd>lua Equip.toggle_quickfix()<CR>', 'Quickfix')

-- f is for 'fuzzy find'
nmap_leader('f/', '<Cmd>Telescope search_history<CR>', '"/" history')
nmap_leader('f:', '<Cmd>Telescope command_history<CR>', '":" history')
nmap_leader('fb', '<Cmd>Telescope buffers<CR>', 'Buffers')
nmap_leader('ff', '<Cmd>Telescope find_files hidden=true<CR>', 'Files')
nmap_leader('fg', '<Cmd>Telescope live_grep<CR>', 'Grep live')
nmap_leader('fG', '<Cmd>Telescope grep_string<CR>', 'Grep current word')
nmap_leader('fh', '<Cmd>Telescope help_tags<CR>', 'Help tags')
nmap_leader('fl', '<Cmd>Telescuope registers<CR>', 'Registers')
-- nmap_leader('fo', '<Cmd>Telescope oldfiles<CR>', 'Oldfiles')
nmap_leader('fo', '<Cmd>Telescope frecency<CR>', 'Recent files')
nmap_leader('fO', '<Cmd>Telescope frecency workspace=CWD<CR>', 'Recent files (CWD)')
nmap_leader('fp', '<Cmd>Telescope persisted<CR>', 'Sessions')
nmap_leader('fr', '<Cmd>Telescope resume<CR>', 'Resume')
nmap_leader('ft', '<Cmd>TodoTelescope<CR>', 'TODO')
nmap_leader('fT', '<Cmd>TodoLocList<CR>', 'TODO Loc')
nmap_leader('fu', '<Cmd>Telescope undo<CR>', 'Undo')
-- TODO: add plugin for managing visits
-- nmap_leader('fv', '<Cmd>Telescope visit_paths cwd=""<CR>', 'Visit paths (all)')
-- nmap_leader('fV', '<Cmd>Telescope visit_paths<CR>', 'Visit paths (cwd)')

-- Pick
-- nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>', '"/" history')
-- nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>', '":" history')
-- nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>', 'Added hunks (all)')
-- nmap_leader('fA', '<Cmd>Picki git_hunks path="%" scope="staged"<CR>', 'Added hunks (current)')
-- nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
-- nmap_leader('fc', '<Cmd>Pick git_commits<CR>', 'Commits (all)')
-- nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>', 'Commits (current)')
-- nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
-- nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
-- nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
-- nmap_leader('fg', '<Cmd>Pick grep_live<CR>', 'Grep live')
-- nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')
-- nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
-- nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>', 'Lines (all)')
-- nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>', 'Lines (current)')
-- nmap_leader('fm', '<Cmd>Pick git_hunks<CR>', 'Modified hunks (all)')
-- nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>', 'Modified hunks (current)')
-- nmap_leader('fr', '<Cmd>Pick resume<CR>', 'Resume')
-- nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>', 'References (LSP)')
-- nmap_leader('fs', '<Cmd>Pick lsp scope="workspace_symbol"<CR>', 'Symbols workspace (LSP)')
-- nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Symbols buffer (LSP)')
-- nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>', 'Visit paths (all)')
-- nmap_leader('fV', '<Cmd>Pick visit_paths<CR>', 'Visit paths (cwd)')

-- g is for git
nmap_leader('gc', '<Cmd>Git commit<CR>', 'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>', 'Commit amend')
-- nmap_leader('gg', '<Cmd>lua Equip.open_lazygit()<CR>', 'Git tab')
-- nmap_leader('gl', '<Cmd>Git log --oneline<CR>', 'Log')
nmap_leader('gl', '<Cmd>Telescope git_commits<CR>', 'Commits (all)')
-- nmap_leader('gL', '<Cmd>Git log --oneline --follow -- %<CR>', 'Log buffer')
nmap_leader('gL', '<Cmd>Telescope git_bcommits<CR>', 'Commits (current)')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')
nmap_leader('gS', '<Cmd>Telescope git_status<CR>', 'Show at cursor')

xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')

-- l is for 'LSP' (Language Server Protocol)
local formatting_cmd = '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>'
nmap_leader('la', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Arguments popup')
nmap_leader('lA', '<Cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Actions')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostics popup')
nmap_leader('lD', '<Cmd>Telescope diagnostics<CR>', 'Diagnostic workspace')
nmap_leader('lf', formatting_cmd, 'Format')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Information')
nmap_leader('lj', '<Cmd>lua vim.diagnostic.goto_next()<CR>', 'Next diagnostic')
nmap_leader('lk', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', 'Prev diagnostic')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')
nmap_leader('lo', '<Cmd>AerialToggle<CR>', 'SymbolsOutline (Aerial)')
nmap_leader('lO', '<Cmd>Vista!!<CR>', 'SymbolsOutline (Vista)')

xmap_leader('lf', formatting_cmd, 'Format selection')

-- -- m is for 'map'
-- nmap_leader('mc', '<Cmd>lua MiniMap.close()<CR>',        'Close')
-- nmap_leader('mf', '<Cmd>lua MiniMap.toggle_focus()<CR>', 'Focus (toggle)')
-- nmap_leader('mo', '<Cmd>lua MiniMap.open()<CR>',         'Open')
-- nmap_leader('mr', '<Cmd>lua MiniMap.refresh()<CR>',      'Refresh')
-- nmap_leader('ms', '<Cmd>lua MiniMap.toggle_side()<CR>',  'Side (toggle)')
-- nmap_leader('mt', '<Cmd>lua MiniMap.toggle()<CR>',       'Toggle')

-- o is for 'other'
local trailspace_toggle_command = '<Cmd>lua vim.b.minitrailspace_disable = not vim.b.minitrailspace_disable<CR>'
-- nmap_leader('od', '<Cmd>Neogen<CR>',                       'Document')
-- nmap_leader('oh', '<Cmd>normal gxiagxila<CR>',             'Move arg left')
-- nmap_leader('oH', '<Cmd>TSBufToggle highlight<CR>', 'Highlight toggle')
-- nmap_leader('og', '<Cmd>lua MiniDoc.generate()<CR>',       'Generate plugin doc')
-- nmap_leader('ol', '<Cmd>normal gxiagxina<CR>',             'Move arg right')
nmap_leader('or', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader('oR', '<Cmd>lua require("smart-splits").start_resize_mode()<CR>', 'Resize mode')
nmap_leader('os', '<Cmd>lua MiniSessions.select()<CR>', 'Session select')
-- nmap_leader('oS', '<Cmd>lua Config.insert_section()<CR>',  'Section insert')
nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>', 'Trim trailspace')
nmap_leader('oT', trailspace_toggle_command, 'Trailspace hl toggle')
nmap_leader('oz', '<Cmd>lua MiniMisc.zoom()<CR>', 'Zoom toggle')

-- W is for splits
nmap_leader('Wh', '<Cmd>SmartSwapLeft<CR>', 'window: Move window leftward')
nmap_leader('Wj', '<Cmd>SmartSwap<CR>', 'window: Move window downward')
nmap_leader('Wk', '<Cmd>SmartSwapUp<CR>', 'window: Move window upward')
nmap_leader('Wl', '<Cmd>SmartSwapUp<CR>', 'window: Move window rightward')