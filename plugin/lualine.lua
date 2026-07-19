vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/SmiteshP/nvim-navic",

})
local lualine_opts = {
    options = {
        globalstatus = true,
        theme = "iceberg_dark",
        icons_enabled = true,
        disabled_filetypes = {
            winbar = { 'NvimTree', 'dashboard','lazy', 'trouble', 'toggleterm','help','dap-view','dap-repl' }, -- Don't show path on these
        },
    },
    winbar = {
        lualine_c = {
            {
                'filename',
                path=0,
                shorting_target = 40,
                color = function(section)
                    return { fg = vim.bo.modified and '#aa3355' or '#33aa88' , bg = nil , gui= 'bold'}
                end,
                fmt = function(name)
                    local devicons = require("nvim-web-devicons")
                    local extension = vim.fn.fnamemodify(name, ':e')
                    local icon, _ = devicons.get_icon(name, extension, { default = true })
                    -- Strip the extension from the name
                    local clean_name = name:gsub("%.%w+$", "")
                    if clean_name == "" then clean_name = name end

                    -- 4. Return the icon + the clean name
                    return icon .. " " .. clean_name
                end,
                -- fmt = function(res) return "     " .. res end
            },
            {
                'filename',
                path=1,
                shorting_target = 40,
                color = { fg = '#404063', bg = nil }
            },
            {
                function()
                    return require("nvim-navic").get_location()
                end,
                cond = function()
                    return require("nvim-navic").is_available()
                end,
                color = { fg = "#00f2ff" }, -- Your high-contrast glow
            },
        },
    },
    inactive_winbar = {
        lualine_c = {
            {
                'filename',
                path=0,
                shorting_target = 40,
            }

        },
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
                function ()
                    local cwd=  " 󱉭 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
                    return cwd
                end,
                color = { fg = "#00f2ff" }, -- Your high-contrast glow
            }
        },
        lualine_x ={
            'lsp_status',
            'encoding',
            'fileformat',
            'filetype'
        }
    },
    extensions = {'toggleterm' , 'oil' , 'nvim-tree'}
}

local navic_opts = {
    icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘",
        Interface     = "󰕘",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = "󰀬 ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪 ",
        Object        = "󰅩 ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
        enabled       = true,
    },
    lsp = {
        auto_attach = false,
        preference = nil,
    },
    highlight = false,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    lazy_update_context = false,
    click = false,
    format_text = function(text)
        return text
    end,
}

require("nvim-navic").setup(navic_opts)
require("lualine").setup(lualine_opts)

