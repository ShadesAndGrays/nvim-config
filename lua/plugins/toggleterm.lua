vim.pack.add({

    "https://github.com/akinsho/toggleterm.nvim",
})
local function load_toggle_term()
    require("toggleterm").setup({
        env = {
            EDITOR = "nvim",
            VISUAL = "nvim",
        }
    })

    load_toggle_term = function() end
end


local kmap = vim.keymap.set

kmap('n', '<s-c>', function()
    load_toggle_term()
    vim.cmd("ToggleTerm direction=horizontal")
end, { desc = "Toggle last terminal (horizontal)" })
