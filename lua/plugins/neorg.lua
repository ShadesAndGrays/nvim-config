return {
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = function ()
            vim.api.nvim_create_autocmd("Filetype", {
                pattern = "norg",
                callback = function()
                    vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
                    vim.keymap.set("n", "<localleader><CR>", "<cmd>Neorg index<CR>", { buffer = true })
                end,
            })

            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {}, -- We added this line!
                    ["core.summary"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes",
                        },
                        -- ["core.itero"] = {}, -- continue list items
                        -- ["core.promo"] = {}, -- allow promoting levels of items
                        ["core.completion"] = {
                            config = {
                                engine = "nvim-cmp",
                            }
                        },
                        ["core.integrations.nvim-cmp"] = {},
                        ["core.integrations.image"] = {},
                    }, -- We added this line!
                }
            })
        end,


    }
}

