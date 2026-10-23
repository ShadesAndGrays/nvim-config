vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })


local opts = {
    file_types = {
        "markdown",
        "Avante",
        "AvanteInput",
        "opencode_output"
    },
    anti_conceal = { enabled = true },
}

require("render-markdown").setup(opts)
