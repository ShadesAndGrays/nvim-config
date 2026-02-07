return {
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.laststatus = 3
            vim.opt.splitkeep = "screen"
        end,
        opts = {
            animate = { enabled = false},
            exit_when_last = true,
            bottom = {
                -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
                {
                    ft = "toggleterm",
                    size = { height = 0.4 },
                    -- exclude floating windows
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                {
                    ft = "lazyterm",
                    title = "LazyTerm",
                    size = { height = 0.4 },
                    filter = function(buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
                {
                    ft = "trouble",
                    size = { height = 0.4 },
                    -- exclude floating windows
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,

                },
                -- "Trouble",
                {
                    ft = "help",
                    size = { height = 20 },
                    -- only show help buffers
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                },
            },
            right = {
                -- Neo-tree filesystem always takes half the screen height
                {
                    title = "NvimTree",
                    ft = "NvimTree",
                    -- filter = function(buf)
                        --     return vim.b[buf].neo_tree_source == "filesystem"
                        -- end,
                        --
                        size = { height = 0.5 },
                    },
                }
            }
        }
    }
