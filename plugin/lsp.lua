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
    -- 'vtsls',
    -- 'yamlls',
    'gdscript',
    -- 'gopls',
    -- html stuff
    -- 'eslint',
    -- 'html',
    -- 'jsonls',
    -- 'gopls',
    -- 'csharp_ls',
    -- 'cssls',
    -- 'tailwindcss',
    -- 'pyright',
    'ols',
    -- 'rust_analyzer'
}

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id);
        local bufnr = args.buf
        vim.notify('Attached '.. client.name .. ' to buffer ' .. bufnr)

        local navic = require("nvim-navic")
        if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end

        local kmap = vim.keymap.set

        -- kmap('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to description" })
        -- kmap('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
        -- kmap('n', '<leader>ga', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
        -- -- Jump to previous error/warning
        -- kmap('n', 'gep', function()
        --     vim.diagnostic.jump({ count = -1, float = true })
        -- end, { buffer = bufnr, desc = "Previous Diagnostic" })
        --
        -- -- Jump to next error/warning
        -- kmap('n', 'gen', function()
        --     vim.diagnostic.jump({ count = 1, float = true })
        -- end, { buffer = bufnr, desc = "Next Diagnostic" })
        --
        -- if client and client.name == 'clangd' then
        --     kmap('n', '<leader>sw', '<cmd>LSPClangdSwitchSourceHeader<cr>',
        --     { buffer = bufnr, desc = "Switch Header/Source" })
        -- end
        -- kmap('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end,
        -- { buffer = bufnr, desc = "Format Code" })
        -- kmap('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
        -- kmap('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Docs" })
        --
        -- kmap('n', 'gqp', '<cmd>cprev<cr>', { desc = "Previous Quickfix" })
        -- kmap('n', 'gqn', '<cmd>cnext<cr>', { desc = "Next Quickfix" })
    end

})

local lsp_util = vim.lsp.util
local old_make_position_params = lsp_util.make_position_params

-- duplicate-set
lsp_util.make_position_params = function(window, offset_encoding)
    -- If window is nil or invalid, default to current window (0)
    if not window or type(window) ~= "number" then
        window = 0
    end
    -- Neovim 0.11 requires offset_encoding; default to utf-16 if missing
    return old_make_position_params(window, offset_encoding or "utf-16")
end

for _, lsp in ipairs(lsps) do
    vim.lsp.config(lsp, {})
    vim.lsp.enable(lsp)
end

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
