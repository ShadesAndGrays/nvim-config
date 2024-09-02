return{
    {"hrsh7th/nvim-cmp",
    config =
    function()
        local cmp = require("cmp")
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-o>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp. mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({select = true}),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end}
                ,
                sources = cmp.config.sources(
                {{name = 'nvim_lsp'}},
                {{ name = 'nvim_lsp_signature_help' }},
                {{name = 'buffer'}},
                {{name = 'luasnip'}}
                )

            })
        end
    },
    {"hrsh7th/cmp-nvim-lsp"},
    {"L3MON4D3/LuaSnip"},
    {
        "neovim/nvim-lspconfig",
        config = function()

            local nvim_lsp = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local on_attach = function(client, bufnr)
                print('Language server attached!, buffer number: ', bufnr, " client: ", client.name)
                -- Your additional setup code can go here
            end

            -- Common setup function
            local function common_setup(server, config)
                nvim_lsp[server].setup(vim.tbl_extend('force', {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }, config or {}))
            end

            local servers = {
                require("../config/lsp_configs/cpp"),
                require("../config/lsp_configs/rust"),
                require("../config/lsp_configs/tsserver"),
                require("../config/lsp_configs/vlang"),
                require("../config/lsp_configs/lua_ls"),
                require("../config/lsp_configs/cmake"),
                require("../config/lsp_configs/solidity"),
                {'gdscript'},
                {'rubocop'},
                {'html'},
                {'cssls'},
                {'pyright'},
                {'fortls'},
                {'gopls'},
           }

        -- Setup each language server
        for _, server in ipairs(servers) do
            local lsp,conf  = unpack(server)
            common_setup(lsp,conf)
        end
    end
},
{"hrsh7th/cmp-nvim-lsp-signature-help"},
{"mfussenegger/nvim-dap"},
}


