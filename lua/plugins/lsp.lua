return {
    -- 1. Snippet Engine
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
            require("luasnip.loaders.from_vscode").lazy_load()

            local ls = require("luasnip")
            vim.keymap.set({ "i", "s" }, "<A-k>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<A-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
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


            -- Define the toggle function
            local cmp_enabled = true
            vim.api.nvim_create_user_command('CmpToggle', function()
                if cmp_enabled then
                    require('cmp').setup({ completion = { autocomplete = false } })
                    vim.notify("Cmp Autocomplete: OFF")
                else
                    require('cmp').setup({ completion = { autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged } } })
                    vim.notify("Cmp Autocomplete: ON")
                end
                cmp_enabled = not cmp_enabled
            end, {})

            -- Optional: Map it to a key (e.g., <leader>ta for "Toggle Auto")
            vim.keymap.set('n', '<leader>ta', '<cmd>CmpToggle<cr>', { desc = 'Toggle CMP Autocomplete' })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' }, -- Order of items in the popup
                    format = function(entry, vim_item)
                        -- Set the fixed width for the 'abbr' (the main text)
                        local fixed_width = 25

                        -- If the content is longer than fixed_width, truncate it
                        if string.len(vim_item.abbr) > fixed_width then
                            vim_item.abbr = string.sub(vim_item.abbr, 1, fixed_width) .. "..."
                        end

                        -- Remove the 'menu' (e.g., [LSP], [Buffer]) to save even more width
                        vim_item.menu = ""

                        return vim_item
                    end,
                },
                window = {

                    completion = {

                        -- This is the key: 'side_padding' helps, but 'col_offset' can move it.
                        -- To force it ABOVE, we use the 'documentation' max_height trick or
                        -- the 'scrolloff' settings.

                        -- Most reliable 2026 method for nvim-cmp:
                        scrollbar = true,
                        max_height = 10,
                        max_width = 5,
                        side_padding = 1,
                        col_offset = 2, -- Move it slightly left so it doesn't cover the first char
                    },
                    documentation = {
                        scrollbar = true,
                        max_height = 15,
                        max_width = 50,
                        side_padding = 1,
                        col_offset = 2, -- Move it slightly left so it doesn't cover the first char
                    },
                },
                view = {
                    auto_open = true,
                    entries = {
                        name = 'custom',
                        selection_order = 'near_cursor',
                        follow_cursor = true
                    },
                    docs = {
                        auto_open = true
                    }
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
                    { name = 'nvim_lsp_signature_help' },                 -- This shows function arguments as you type
                    { name = 'luasnip' },
                    { name = 'lazydev',                group_index = 0 }, -- For Neovim API
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end,
    },


    -- 3. LSP Configuration (The Missing Piece)
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            local lsps = {
                'clangd',
                'cmake',
                'lua_ls',
                'vtsls',
                'yamlls',
                'gdscript',
                'gopls',
                -- html stuff
                'eslint',
                'html',
                'jsonls',
                'gopls',
                'csharp_ls',
                'cssls',
                'tailwindcss',
                'pyright',
                --'pylsp',
                'rust_analyzer' -- forgive me lord
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

                    Kmap('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to description" })
                    Kmap('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
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
                        Kmap('n', '<leader>sw', '<cmd>LSPClangdSwitchSourceHeader<cr>',
                            { buffer = bufnr, desc = "Switch Header/Source" })
                    end
                    Kmap('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end,
                        { buffer = bufnr, desc = "Format Code" })
                    Kmap('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
                    Kmap('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Docs" })

                    Kmap('n', 'gqp', '<cmd>cprev<cr>', { desc = "Previous Quickfix" })
                    Kmap('n', 'gqn', '<cmd>cnext<cr>', { desc = "Next Quickfix" })
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
                vim.lsp.config(lsp, { capabilities = capabilities })
                vim.lsp.enable(lsp)
            end

            -- vim.lsp.enable('vacuum')

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
        end,
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "lazy.nvim",          words = { "LazySpec" } },
            }
        }
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "b0o/SchemaStore.nvim",
        lazy = true, -- Only loads when called by jsonls
    }
}
