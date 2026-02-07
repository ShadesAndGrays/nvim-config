return{
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = "iceberg_dark",
                icons_enabled = true,
            },
            tabline = {
                lualine_a = {
                    {
                        'datetime',
                        -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
                        style = 'default'
                    },
                },

                lualine_b = {{
                    'buffers',
                    show_filename_only=true,
                    hide_filename_extension= true,
                    show_modified_status = true,

                    mode = 2, -- 0: Shows buffer name
                    -- 1: Shows buffer index
                    -- 2: Shows buffer name + buffer index
                    -- 3: Shows buffer number
                    -- 4: Shows buffer name + buffer number

                    max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                    -- it can also be a function that returns
                    -- the value of `max_length` dynamically.
                    filetype_names = {
                        TelescopePrompt = 'Telescope',
                        dashboard = 'Dashboard',
                        packer = 'Packer',
                        lazy = 'Lazy',
                        fzf = 'FZF',
                        NvimTree = 'NvimTree',
                    }
                }},
                lualine_z = {
                    {'tabs'},
                    {
                        'searchcount',
                        maxcount = 999,
                        timeout = 500,
                    }
                }
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path=1,
                        shorting_target = 40,
                    }

                },
                lualine_x ={
                    'lsp_status',
                    'encoding',
                    'fileformat',
                    'filetype'
                }
            },
            extensions = {'toggleterm'}
        }
    }
}
