--@type LazySpec[]
return {
    {
        'ray-x/web-tools.nvim',
        opts = {
            keymaps = {
                rename = nil,  -- by default use same setup of lspconfig
                repeat_rename = '.', -- . to repeat
            },
            hurl = {  -- hurl default
                show_headers = false, -- do not show http headers
                floating = false,   -- use floating windows (need guihua.lua)
                json5 = false,      -- use json5 parser require json5 treesitter
                formatters = {  -- format the result by filetype
                    json = { 'jq' },
                    html = { 'prettier', '--parser', 'html' },
                },
            },
        }
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {
            opts = {
                -- Defaults
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            per_filetype = {}

        }
    }
}
