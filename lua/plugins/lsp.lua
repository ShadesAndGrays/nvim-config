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
            vim.lsp.config('*', { capabilities = capabilities })
            -- looks into after/lsp/ directory for: 
            vim.lsp.enable('clangd')
            vim.lsp.enable('cmake')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('vtsls')

            -- vim.lsp.enable('vacuum')
            vim.lsp.enable('yamlls')

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
    }
}
