vim.pack.add({ "https://github.com/folke/edgy.nvim" })

vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

local opts = {
    animate = { enabled = false },
    exit_when_last = true,
    -- GLOBAL OPTIONS ARE KEY HERE
    options = {
        -- This ensures sidebars (right) leave room for the bottom
        bottom = { size = 0.25 },
        right = { size = 30 },
    },
    bottom = {
        {
            ft = "toggleterm",
            size = { height = 0.25 },
            -- FORCE winfixheight so it doesn't expand when top windows close
            wo = { winfixheight = true },
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        {
            ft = "trouble",
            size = { height = 0.25 },
            wo = { winfixheight = true },
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        {
            ft = "help",
            size = { height = 20 },
            wo = { winfixheight = true },
            filter = function(buf)
                return vim.bo[buf].buftype == "help"
            end,
        },
    },
    right = {
        {
            title = "NvimTree",
            ft = "NvimTree",
            -- Use width for right panel, NOT height
            -- If you use height here, it tries to split vertically within the right slot
            size = { width = 30 },
        },
    }
}

require("edgy").setup(opts)

