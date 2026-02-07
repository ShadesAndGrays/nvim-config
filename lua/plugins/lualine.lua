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

                lualine_b = {'buffers'}
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
