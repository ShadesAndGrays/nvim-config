return {
    {
        "lewis6991/gitsigns.nvim",
    },
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen HEAD^<cr>", desc = "Review Aider Changes" },
        { "<leader>gx", "<cmd>DiffviewClose<cr>",      desc = "Close Diff View" },
    },
}
