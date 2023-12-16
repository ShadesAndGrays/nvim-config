return{
    {
        "neovim/nvim-lspconfig",
        config = function()

            nvim_lsp = require("lspconfig")
            local servers = {"lua","pyright", "clangd","cmake","rust_analyzer","v_analyzer"}

            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }
            end

        end
    },
}

