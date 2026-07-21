local capabilities = vim.lsp.protocol.make_client_capabilities()

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
    }
}
