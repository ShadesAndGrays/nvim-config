return {
    {"pocco81/auto-save.nvim", 
    config = function()
        require("auto-save").setup {
            kmap("n", "<leader>s", ":ASToggle<CR>", {})
            -- your config goes here
            -- or just leave it empty :)
        }
    end,
}
}
