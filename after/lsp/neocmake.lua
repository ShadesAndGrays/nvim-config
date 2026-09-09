local capabilities = require('blink.cmp').get_lsp_capabilities()

return {

    capabilities = capabilities,

    cmd = {
        "neocmakelsp", "stdio"
    },

    filetypes = {
        "cmake",
    },

    root_markers = {
        ".neocmake.toml",
        ".git",
        "build",
        "cmake",
    },

    single_file_support = false,

    before_init = function(p, c)
        vim.env.PATH = "C:\\msys64\\clang64\\bin:" .. vim.env.PATH
    end,

    init_options = {
        format = { enable = true },
        lint = { enable = true },
        scan_cmake_in_package = true
    },


}
