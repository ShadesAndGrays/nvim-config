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

local on_attach = function(client, bufnr)
    print('Language server attached!')

    -- Your additional setup code can go here
end


            local cap = require('cmp_nvim_lsp').default_capabilities()
            local nvim_lsp = require("lspconfig")

            -- Common setup function
            local function common_setup(server, config)
                nvim_lsp[server].setup(vim.tbl_extend('force', {
                    on_attach = on_attach,
                    capabilities = cap,
                }, config or {}))
            end

            local servers = {
                {'tsserver'},
                {'html'},
                {'cssls'},
                {'lua_ls',
                {
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT',
                                path = vim.split(package.path, ';'), -- Use appropriate path separator
                            },
                            completion = {
                                callSnippet = 'Replace',
                            },
                            diagnostics = {
                                enable = true,
                                globals = { 'vim', 'use' },
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file('', true),
                                maxPreload = 10000,
                                preloadFileSize = 10000,
                            },
                            telemetry = { enable = false },
                        },
                    },
                }},
                {'pyright'},
                {'clangd',{

                    cmd = { 'clangd', '--compile-commands-dir=.' },
                    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
                    root_dir = nvim_lsp.util.root_pattern('compile_commands.json', '.git'),

                }},
                {'cmake'},
                {'rust_analyzer'},
                {'vls'}
            }

            -- Setup each language server
            for _, server in ipairs(servers) do
                local lsp,conf  = unpack(server)
                common_setup(lsp,conf)
            end




        end
    },
}

