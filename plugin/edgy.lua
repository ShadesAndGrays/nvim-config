vim.pack.add({ "https://github.com/folke/edgy.nvim" })

vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

local opts = {}
opts.animate = { enabled = false }
opts.exit_when_last = true
opts.options = {
    -- This ensures sidebars (right) leave room for the bottom
    bottom = { size = 0.2 },
    right = { size = 30 },
}



opts.bottom = opts.bottom or {}
opts.right = opts.right or {}

opts.left = {
}

opts.bottom = {
    -- FORCE winfixheight so it doesn't expand when top windows close
    {
        ft = "toggleterm",
        -- size = { height = 0.25 },
        -- wo = { winfixheight = true },
        filter = function(buf, win)
            return
                vim.api.nvim_win_get_config(win).relative == ""
        end
    },
    {
        ft = "trouble",
        -- size = { height = 0.25 },
        -- wo = { winfixheight = true },
        filter = function(buf, win)
            return vim
                .api.nvim_win_get_config(win).relative == ""
        end,
    },
}
opts.right = {
    {
        title = "NvimTree",
        ft = "NvimTree",
        -- Use width for right panel, NOT height
        -- If you use height here, it tries to split vertically within the right slot
        size = { width = 30 },
    },

    {
        ft = "help",
        size = { height = 0.5, width = 0.3 },
        wo = { winfixheight = true },
        filter = function(buf)
            return vim.bo
                [buf].buftype == "help"
        end,
    },
}
vim.list_extend(opts.right, {
    { ft = "dapui_scopes",      title = "Scopes",      size = { height = 0.4 },  wo = { winfixheight = true } },
    { ft = "dapui_breakpoints", title = "Breakpoints", size = { height = 0.15 }, wo = { winfixheight = true } },
    { ft = "dapui_stacks",      title = "Stacks",      size = { height = 0.2 },  wo = { winfixheight = true } },
    { ft = "dapui_watches",     title = "Watches",     size = { height = 0.15 }, wo = { winfixheight = true } },
    { ft = "dapui_registers",   title = "Registers",   size = { height = 0.1 },  wo = { winfixheight = true } },
})

vim.list_extend(opts.bottom, {
    { ft = "dapui_repl",    title = "REPL",    size = { height = 0.25, width = 0.3 }, wo = { winfixwidth = false } },
    -- { ft = "dapui_console", title = "Console", size = { height = 0.25, width = 0.5 }, wo = { winfixwidth = false } },
})

require("edgy").setup(opts)
