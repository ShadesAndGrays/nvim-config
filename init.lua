require("config.keymaps")
require("config.lazy")
require("config.options")
require("config.whichkey")
require("config.autocommands")
require("config.treesitter")
-- require("config.indent") -- for indent-backline


require("lualine").setup()
-- Setting up plugins
-- require("ufo").setup()
require("autoclose").setup()
require("trouble").setup()
require('Comment').setup()
require('gitsigns').setup()
require('nvim-navic').setup()


--Setting up for the web
require'web-tools'.setup()
require('nvim-ts-autotag').setup()

require("lazydev").setup()
require("nvim-tree").setup()

-- require("practice.window")
