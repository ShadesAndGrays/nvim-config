
return{{
    "nvim-tree/nvim-tree.lua",
    opts = {
        disable_netrw=true,
        sync_root_with_cwd = true,     -- This is the big one!
        respect_buf_cwd = true,        -- Changes the tree root if your buffer changes
        update_focused_file = {
            enable = true,               -- Follows your cursor as you switch tabs
            update_root = true,          -- Changes the tree root to match the file
        },

        sort = {
            sorter = "case_sensitive",
        },
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    }
}}
