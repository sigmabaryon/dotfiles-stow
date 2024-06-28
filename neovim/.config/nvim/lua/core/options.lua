vim.g.mapleader = ' '

vim.o.mousescroll = 'ver:25,hor:6'
vim.o.switchbuf = 'usetab' -- Use already opened buffers when switching

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

vim.o.colorcolumn = '+1' -- Draw colored column one step to the right of desired maximum width
vim.o.laststatus = 2 -- Always show statusline
vim.o.showtabline = 2 -- Always show tabline
vim.o.termguicolors = true -- Enable gui colors
vim.o.cmdheight = 0

vim.o.cursorlineopt = 'screenline,number' -- Show cursor line only screen line when wrapped

vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = 'rqnl1j' -- Improve comment editing
vim.o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch = true -- Show search results while typing
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.virtualedit = 'block' -- Allow going past the end of line in visual block mode

vim.opt.iskeyword:append('-') -- Treat dash separated words as a word text object

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list
-- item'
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.sessionoptions = 'buffers,curdir,folds,tabpages,winpos,winsize,localoptions'

vim.o.spelllang = 'en_us' -- Define spelling dictionaries
vim.o.spelloptions = 'camel' -- Treat parts of camelCase words as seprate words
vim.opt.complete:append('kspell') -- Add spellcheck options for autocomplete
vim.opt.complete:remove('t') -- Don't use tags for completion

vim.o.dictionary = vim.fn.stdpath('config') .. '/misc/dict/english.txt' -- Use specific dictionaries

vim.o.foldmethod = 'indent' -- Set 'indent' folding method
vim.o.foldlevel = 1 -- Display all folds except top ones
vim.o.foldnestmax = 10 -- Create folds only for some number of nested levels
vim.g.markdown_folding = 1 -- Use folding by heading in markdown files

vim.o.grepprg = 'rg --hidden --vimgrep --smart-case --'
vim.o.wildignore =
  '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
vim.o.wildignorecase = true

if vim.fn.has('nvim-0.10') == 1 then
  vim.o.foldtext = '' -- Use underlying text with its highlighting
end

local augroup = vim.api.nvim_create_augroup('CustomSettings', {})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function()
    -- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
    -- If don't do this on `FileType`, this keeps reappearing due to being set in
    -- filetype plugins.
    vim.cmd('setlocal formatoptions-=c formatoptions-=o')
  end,
  desc = [[Ensure proper 'formatoptions']],
})
