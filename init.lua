vim.pack.add({
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/ellisonleao/carbon-now.nvim",
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    'https://github.com/numToStr/Comment.nvim',
    'https://github.com/HiPhish/rainbow-delimiters.nvim',
    "https://github.com/nvzone/typr",

})

require("config/keymaps")
require("config/options")
require("config/autocommands")


if vim.g.neovide then
    -- 'expand' handles the Windows home path correctly
    vim.fn.chdir(vim.fn.expand("~"))
end

-- Change notification system to notify
vim.notify = require("notify")
vim.notify("Loaded config", vim.log.levels.INFO, { title = "init.lua" })

vim.cmd('colorscheme catppuccin-mocha')


-- Set shell to pwsh, configuring flags for encoding and execution policy
local powershell_options = {
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellquote = "",
    shellxquote = "",
}

for option, value in pairs(powershell_options) do
    vim.opt[option] = value
end

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    }
})

vim.lsp.config('*', {
    root_markers = { '.git', '.hg' },
})
