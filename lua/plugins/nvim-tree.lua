
return{{
    "nvim-tree/nvim-tree.lua",
    opts = {
        disable_netrw=true,
        -- sync_root_with_cwd=true,
        -- respect_buf_cwd = true,

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
