vim.pack.add({

    "https://github.com/akinsho/toggleterm.nvim",
})
require("toggleterm").setup({
    env = {
        EDITOR = "nvim",
        VISUAL = "nvim",
    }
})
