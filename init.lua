-- global plugins
vim.pack.add({
    "https://github.com/rcarriga/nvim-notify",
})
require("notify").setup({
    background_colour = "#000000",
})

-- Color scheme
vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/rebelot/kanagawa.nvim.git",
    "https://github.com/navarasu/onedark.nvim",
    "https://github.com/tiagovla/tokyodark.nvim",
    "https://github.com/datsfilipe/vesper.nvim"

})

-- Change notification system to notify
vim.notify = require("notify")
vim.notify("Loaded config", vim.log.levels.INFO, { title = "init.lua" })

require("config.keymaps")         -- global keymaps
require("config.options")         -- global options
require("config.autocommands")    -- global autocommands
require("config.neovide").setup() -- detect and enable neovim options

vim.cmd('colorscheme catppuccin')


-- switch to powershell for windows
if _G.IS_WINDOWS then
    local powershell_options = {
        shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
        shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellquote = "",
        shellxquote = "",
    }

    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end
