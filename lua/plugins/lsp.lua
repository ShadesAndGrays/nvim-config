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
                {{name = 'luasnip'}},
                {{name = 'lazydev'}},
                {{name = 'neorg'}}
                )

            })
        end
    },
    {"hrsh7th/cmp-nvim-lsp"},
    {"L3MON4D3/LuaSnip",
    config = function ()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
    dependencies = { "rafamadriz/friendly-snippets" }
},

{
    "neovim/nvim-lspconfig",
    config = function()

        local nvim_lsp = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local on_attach = function(client, bufnr)
            print('Language server attached!, buffer number: ', bufnr, " client: ", client.name)
            -- Your additional setup code can go here
            local keymap_opts = { buffer = bufnr }
            Kmap("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
            Kmap("n", "K", vim.lsp.buf.hover, keymap_opts)
            Kmap("n", "gD", vim.lsp.buf.implementation, keymap_opts)
            Kmap("n", "gH", vim.lsp.buf.signature_help, keymap_opts)
            Kmap("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
            Kmap("n", "gr", vim.lsp.buf.references, keymap_opts)
            Kmap("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
            Kmap("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
            Kmap("n", "gd", vim.lsp.buf.definition, keymap_opts)
            Kmap("n", "ga", vim.lsp.buf.code_action, keymap_opts)
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
            -- require("../config/lsp_configs/rust"),
            require("../config/lsp_configs/emmet"),
            require("../config/lsp_configs/ts"),
            require("../config/lsp_configs/vlang"),
            require("../config/lsp_configs/lua_ls"),
            -- require("../config/lsp_configs/cmake"),
            { 'neocmake'},
            require("../config/lsp_configs/solidity"),
            require("../config/lsp_configs/ols"),
            {'gdscript'},
            {'rubocop'},
            {'html'},
            {'cssls'},
            {'pyright'},
            {'fortls'},
            {'gopls'},
            {'dartls'},
            {'rust_analyzer'},

        }

        -- Setup each language server
        for _, server in ipairs(servers) do
            local lsp,conf  = unpack(server)
            common_setup(lsp,conf)
        end
    end
},
{"hrsh7th/cmp-nvim-lsp-signature-help"},
{
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
        library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
},
}


