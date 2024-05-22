require("config.keymaps")
require("config.lazy")
require("config.whichkey")
require("config.autocommands")


-- Look and feel
--require("gotham").load()

require("lualine").setup()
-- Setting up plugins
require("ufo").setup()
require("autoclose").setup()
require("auto-save").setup()
require('Comment').setup()
--Setting up for the web
require'web-tools'.setup({
  keymaps = {
    rename = nil,  -- by default use same setup of lspconfig
    repeat_rename = '.', -- . to repeat
  },
  hurl = {  -- hurl default
    show_headers = false, -- do not show http headers
    floating = false,   -- use floating windows (need guihua.lua)
    json5 = false,      -- use json5 parser require json5 treesitter
    formatters = {  -- format the result by filetype
      json = { 'jq' },
      html = { 'prettier', '--parser', 'html' },
    },
  },
})

vim.cmd([[au BufNewFile,BufRead *.v set filetype=vlang]])
vim.opt.number = true
vim.opt.signcolumn = "yes" -- show the sign column always
vim.opt.list = true -- show list chars
vim.opt.listchars = {
    -- these list chars
    tab = "<->",
    nbsp = "␣",
    extends = "…",
    precedes = "…",
    trail = "·",
    multispace = "·", -- show chars if I have multiple spaces between text
    leadmultispace = " ", -- ...but don't show any when they're at the start
}
vim.cmd('colorscheme catppuccin-mocha')
vim.opt.cursorline = true
vim.opt.laststatus = 3 -- single global statusline

vim.g.bulitin_lsp = true
vim.opt.termguicolors = true
-- Searching
vim.opt.wildmenu = true -- tab complete on command line
vim.opt.ignorecase = true -- case insensitive search...
vim.opt.smartcase = true -- unless I use caps
vim.opt.hlsearch = true -- highlight matching text
vim.opt.incsearch = true -- update results while I type

-- Indentation
vim.opt.autoindent = true -- continue indentation to new line
vim.opt.smartindent = true -- add extra indent when it makes sense
vim.opt.smarttab = true -- <Tab> at the start of a line behaves as expected
vim.opt.expandtab = true -- <Tab> inserts spaces
vim.opt.shiftwidth = 4 -- >>, << shift line by 4 spaces
vim.opt.tabstop = 4 -- <Tab> appears as 4 spaces
vim.opt.softtabstop = 4 -- <Tab> behaves as 4 spaces when editing

-- General settings
vim.g.autoread = true -- sense file changes
vim.g.noswapfile = true -- no trashy swap files
-- vim.opt.clipboard = 'unnamedplus' -- save to clipboard always
vim.o.foldenable = false -- disable folds. I'll set them myself

vim.g.vimspector_enable_mappings = 'HUMAN'
