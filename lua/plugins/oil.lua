vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/stevearc/oil.nvim',

})

local oil_loaded = false

local function load_oil()
    require("oil").setup({
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
        },


        keymaps = {
            ["<leader>h"] = { "actions.parent", mode = "n" },
            ["<leader>r"] = "actions.refresh",
            ["<leader>l"] = { "actions.select", mode = "n" },
            ["gcd"] = { "actions.tcd", mode = "n" },
            ["<esc><esc>"] = { "actions.close", mode = "n" },
        }

    })
    load_oil = function() end;
end

if vim.fn.argc() > 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    load_oil()
end


local kmap = vim.keymap.set
kmap("n", "<leader>fo", function()
    load_oil(); require("oil").open()
end, { desc = "open parent directory" })
