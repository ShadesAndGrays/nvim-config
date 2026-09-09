vim.pack.add({

    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim"
})

local function load_telescope()
    local telescope = require('telescope')

    local actions = require("telescope.actions")
    telescope.setup({
        defaults = {
            mappings = {
                i = { -- Insert mode
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-d>"] = actions.delete_buffer,
                    ["<C-i>"] = actions.preview_scrolling_up,
                    ["<C-o>"] = actions.preview_scrolling_down,
                },
                n = {
                    ["q"] = actions.close,
                    ["<C-d>"] = actions.delete_buffer,
                    ["<C-i>"] = actions.preview_scrolling_up,
                    ["<C-o>"] = actions.preview_scrolling_down,
                },
            }
        },
        pickers = {
            find_files = {
                theme = "ivy",
                hidden = false,
            },
            buffers = {
                theme = "dropdown",
                hidden = false,
            },
            spell_suggest = {
                theme = "cursor",
            },
            keymaps = {
                theme = "ivy",
            }
        },
        extensions = {
            fzf = {}

        }
    })



    load_telescope = function() end
end

local kmap = vim.keymap.set

-- Kmap('n', '<leader>fg', builtin.live_grep, {}) -- replaced with multigrep
kmap('n', '<leader>fcc',
    function()
        load_telescope()
        require('telescope.builtin').find_files {
            cwd = vim.fn.stdpath('config')
        }
    end
    , { desc = "Config files" }) -- open telescope in configuration directory

kmap('n', '<leader>fpp',

    function()
        load_telescope()
        require('telescope.builtin').find_files {
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
    end
    , { desc = "Plugin files" }) -- open telescope in configuration directory

kmap('n', '<leader>ff', function()
    load_telescope(); require('telescope.builtin').find_files()
end, { desc = "Telescope find files" })

kmap('n', '<leader>fb', function()
    load_telescope(); require('telescope.builtin').buffers()
end, { desc = "Telescope find buffers" })

kmap('n', '<leader>fh', function()
    load_telescope(); require('telescope.builtin').help_tags()
end, { desc = "Telescope find help" })
kmap('n', '<leader>fs', function()
    load_telescope(); require('telescope.builtin').spell_suggest()
end, { desc = "Telescope spell suggest" }) -- I mess up a lot
kmap('n', '<leader>fk', function()
    load_telescope(); require('telescope.builtin').keymaps()
end, { desc = "Telescope find keymap" })
kmap('n', '<leader>fcm', function()
    load_telescope(); require('telescope.builtin').commands()
end, { desc = "Telescope find commands" }) -- I am a god now
kmap('n', '<leader>fch', function()
    load_telescope(); require('telescope.builtin').command_history()
end, { desc = "Telescope find previuos commands commands" }) --
--kmap('n', '<leader>fp', telescope.extensions.project.project, {desc = "Telescope Project View"})
--kmap("n", "<leader>fz", telescope.extensions.zoxide.list, {desc = "Find Recent directories"})
kmap('n', '<leader>mk', function() require("config.telescope.make").picker() end, { desc = "Telescope MakefileTargets" })

kmap("n", "<leader>fg", function()
    load_telescope(); require('config.telescope.multigrep').live_multigrep()
end, { desc = "Multi Grep" })

vim.api.nvim_create_user_command("ColorSchemePick", function()
    builtin.colorscheme({
        enable_preview = true,
        ignore_builtins = true
    })
end, {})
