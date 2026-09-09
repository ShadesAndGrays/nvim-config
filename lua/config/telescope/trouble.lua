local actions = require("telescope.actions")

local open_with_trouble = require("trouble.sources.telescope").open

local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
    defaults = {
        mappings = {
            i = { ["<c-t>"] = open_with_trouble },
            n = { ["<c-t>"] = open_with_trouble },
        },
    },
})
