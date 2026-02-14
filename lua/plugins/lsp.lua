return {
    -- 1. Snippet Engine
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- 2. Completion Engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",                -- LSP source
            "hrsh7th/cmp-buffer",                  -- Buffer source
            "hrsh7th/cmp-path",                    -- Filesystem path source
            "hrsh7th/cmp-nvim-lsp-signature-help", -- Signature help source
            "saadparwaiz1/cmp_luasnip",            -- Snippet source
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(), -- Use Space or O
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' }, -- This shows function arguments as you type
                    { name = 'luasnip' },
                    { name = 'lazydev', group_index = 0 }, -- For Neovim API
                }, {
                    { name = 'buffer' },
                })
            })
        end,
    },


    -- 3. LSP Configuration (The Missing Piece)
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsps = { 
                'clangd',
                'cmake',
                'lua_ls',
                'pyright',
                'vtsls',
                'yamlls',
                'gdscript'
            }

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id);
                    local bufnr = args.buf
                    -- print('Attached'.. client .. "on" .. bufnr)
                    local navic = require("nvim-navic")
                    if client and client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                    end

                    Kmap('n', 'gd', vim.lsp.buf.definition, {buffer = bufnr, desc="Go to description"})
                    Kmap('n', 'gr', vim.lsp.buf.references, {buffer = bufnr, desc="Go to references"})
                    Kmap('n', '<leader>ga', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
                    -- Jump to previous error/warning
                    Kmap('n', 'gep', function() 
                        vim.diagnostic.jump({ count = -1, float = true }) 
                    end, { buffer = bufnr, desc = "Previous Diagnostic" })

                    -- Jump to next error/warning
                    Kmap('n', 'gen', function() 
                        vim.diagnostic.jump({ count = 1, float = true }) 
                    end, { buffer = bufnr, desc = "Next Diagnostic" })

                    if client and client.name == 'clangd' then
                        Kmap('n', '<leader>sw', '<cmd>LSPClangdSwitchSourceHeader<cr>', { buffer = bufnr, desc = "Switch Header/Source" })
                    end
                    Kmap('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, { buffer = bufnr, desc = "Format Code" })
                    Kmap('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
                    Kmap('n', 'K',  vim.lsp.buf.hover,      {buffer = bufnr, desc="Show Docs"})
                    Kmap('n', '<C-k>',      vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })

                    Kmap('n', 'gqp', '<cmd>cprev<cr>', { desc = "Previous Quickfix" })
                    Kmap('n', 'gqn', '<cmd>cnext<cr>', { desc = "Next Quickfix" })
                end

            })
            for  _,lsp in ipairs(lsps) do
                vim.lsp.config( lsp, { capabilities = capabilities })
                vim.lsp.enable(lsp)
            end

            -- vim.lsp.enable('vacuum')

            vim.filetype.add {
                pattern = {
                    ['openapi.*%.ya?ml'] = 'yaml.openapi',
                    ['openapi.*%.json'] = 'json.openapi',
                },
            }
        end,
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "lazy.nvim", words = { "LazySpec" } },
            }
        }
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    }
}
