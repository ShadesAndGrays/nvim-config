local nvim_lsp = require("lspconfig")

return {
    'ols',{
        require'lspconfig'.ols.setup {
            cmd =   { "ols" },
            init_options = {
                checker_args = "-strict-style",
                collections = {
                    { name = "shared", path = vim.fn.expand('$HOME/odin-lib') }
                },
            },
            filetypes =  { "odin" },
            root_dir= nvim_lsp.util.root_pattern("ols.json", ".git", "*.odin"),

        }
    }
}
