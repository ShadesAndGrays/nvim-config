vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/nvim-mini/mini.completion.git',
    'https://github.com/b0o/SchemaStore.nvim',
    'https://github.com/folke/lazydev.nvim',
})

require("mason").setup()
require("mini.completion").setup()
require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim",          words = { "LazySpec" } },
    }

})

local lsps = {
    'clangd',
    'cmake',
    'lua_ls',
    'vtsls',
    -- 'yamlls',
    'gdscript',
    -- html stuff
    -- 'eslint',
    -- 'html',
    -- 'jsonls',
    'gopls',
    'csharp_ls',
    -- 'cssls',
    -- 'tailwindcss',
    'pyright',
    -- 'glsl_analyzer',
    'ols',
    'rust_analyzer'
}

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        if not client then return end

        vim.notify('Attached ' .. client.name .. ' to buffer ' .. bufnr)

        local navic = require("nvim-navic")
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end


        -- --- Keymaps ---
        local kmap = vim.keymap.set

        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            -- toggle inlayhints

            kmap('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to description" })
            kmap("n", "<leader>ih", "<cmd>lua LSPToggleInLayHint()<cr>", { silent = true })
            function LSPToggleInLayHint()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
            end

            if client:supports_method("textDocument/onTypeFormatting") then
                vim.lsp.on_type_formatting.enable(true, { client_id = client_id })
            end
        end

        if client and client.server_capabilities.documentFormattingProvider then
            -- Fallback to common standards if the server doesn't explicitly advertise its size
            vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
        end

        if client:supports_method("textDocument/semanticTokens/full") then
            client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = client.server_capabilities.semanticTokensProvider.legend
            }
        end

        if client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })

            -- Highlight matching symbols when cursor holds still
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = "lsp_document_highlight",
                buffer = args.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            -- Clear the highlights when the cursor moves again
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                group = "lsp_document_highlight",
                buffer = args.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.diagnostic.open_float(nil, { focusable = false })
            end,
        })

        kmap('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to description" })
        kmap('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
        kmap('n', '<leader>ga', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
        kmap('v', '<leader>ga', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })

        kmap('n', 'gep', function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, { buffer = bufnr, desc = "Previous Diagnostic" })

        kmap('n', 'gen', function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, { buffer = bufnr, desc = "Next Diagnostic" })

        if client.name == 'clangd' then
            kmap('n', '<leader>sw', '<cmd>ClangdSwitchSourceHeader<cr>',
                { buffer = bufnr, desc = "Switch Header/Source" })
        end

        kmap('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end,
            { buffer = bufnr, desc = "Format Code" })
        kmap('v', '<leader>fm', ":lua vim.lsp.buf.format()<CR>", { buffer = bufnr, desc = "Range Format Code" })

        kmap('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
        kmap('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Docs" })

        kmap('n', 'gqp', '<cmd>cprev<cr>', { desc = "Previous Quickfix" })
        kmap('n', 'gqn', '<cmd>cnext<cr>', { desc = "Next Quickfix" })

        vim.diagnostic.config({
            -- virtual_text = {
            --     spacing = 4,
            --     prefix = "●", -- Subtle bullet point instead of long text strings
            -- },
            -- virtual_lines = true,
            severity_sort = true,   -- Always prioritize showing Errors above Warnings
            float = {
                border = "rounded", -- Adds a beautiful clean border to popup diagnostic windows
                source = "if_many", -- Shows exactly which tool (clangd, clang-tidy) threw the error
                header = "",
                max_width = 80,
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN]  = "󰀪 ",
                    [vim.diagnostic.severity.HINT]  = "󰌶 ",
                    [vim.diagnostic.severity.INFO]  = "󱀕 ",
                },
            },

        })
    end


})

-- --- Global LSP Utilities & Overrides ---
local lsp_util = vim.lsp.util
local old_make_position_params = lsp_util.make_position_params

-- Fixed: Neovim 0.11 encoding fallback patch
lsp_util.make_position_params = function(window, offset_encoding)
    if not window or type(window) ~= "number" then
        window = 0
    end
    return old_make_position_params(window, offset_encoding or "utf-16")
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()

-- --- Server Initialization Loop ---
-- Assumes a global or local table 'lsps' exists above this chunk
for _, lsp in ipairs(lsps or {}) do
    vim.lsp.config(lsp, {})
    vim.lsp.enable(lsp)
end

-- --- Filetype Configurations & Globals ---
vim.filetype.add {
    pattern = {
        ['openapi.*%.ya?ml'] = 'yaml.openapi',
        ['openapi.*%.json'] = 'json.openapi',
    },
}

vim.g.autotag_filetype_dict = {
    typescriptreact = "typescript",
    javascriptreact = "javascript"
}
