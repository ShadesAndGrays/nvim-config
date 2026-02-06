require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.whichkey")
require("config.autocommands")
require("config.treesitter")
require("config.indent")


-- Look and feel
--require("gotham").load()

require("lualine").setup()
-- Setting up plugins
-- require("ufo").setup()
require("autoclose").setup()
require("trouble").setup()
require('Comment').setup()
require('gitsigns').setup()


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

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
  }
})

-- enable inlay
vim.lsp.inlay_hint.enable()
require("lazydev").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


require("practice.window")
