return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },

        -- must use config to load options cause extensions need to be loaded
        config = function()
            local telescope = require('telescope')
            telescope.setup({
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
                        theme = "dropdown",
                    }
                },
                extensions = {
                    fzf = {}

                }
        })

            telescope.load_extension('fzf')
            telescope.load_extension('project')
            telescope.load_extension('zoxide')

            local builtin = require('telescope.builtin')

            -- Kmap('n', '<leader>fg', builtin.live_grep, {}) -- replaced with multigrep
            Kmap('n', '<leader>fcc',
            function ()
                builtin.find_files{
                    cwd = vim.fn.stdpath('config')
                }
            end
            , {}) -- open telescope in configuration directory

            Kmap('n', '<leader>fpp',
            function ()
                builtin.find_files{
                    cwd = vim.fs.joinpath(vim.fn.stdpath("data"),"lazy")
                }
            end
            , {}) -- open telescope in configuration directory
            Kmap('n', '<leader>ff', builtin.find_files, {desc = "Telescope find files"})
            Kmap('n', '<leader>fb', builtin.buffers, {desc = "Telescope find buffers"})
            Kmap('n', '<leader>fh', builtin.help_tags, {desc = "Telescope find help"})
            Kmap('n', '<leader>fs', builtin.spell_suggest, {desc = "Telescope spell suggest"}) -- I mess up a lot
            Kmap('n', '<leader>fk', builtin.keymaps, {desc = "Telescope find keymap"})
            Kmap('n', '<leader>fco', builtin.commands, {desc = "Telescope find commands"}) -- I am a god now
            -- Kmap('n', '<leader>fqf', builtin.quickfix, {desc = "Telescope quick fix"})
            Kmap('n', '<leader>fch', builtin.command_history, {desc = "Telescope find previuos commands commands"}) -- 
            Kmap('n', '<leader>fp', telescope.extensions.project.project, {desc = "Telescope Project View"})
            Kmap("n", "<leader>fz", telescope.extensions.zoxide.list, {desc = "Find Recent directories"})

            -- local actions = require("telescope.actions")
            -- local open_with_trouble = require("trouble.sources.telescope").open

            -- Kmap("n", "<leader>dd", open_with_trouble, {desc = "Find Recent directories"})

            require('config.telescope.multigrep').setup()
        end
    },
    {
        'nvim-telescope/telescope-project.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'jvgrootveld/telescope-zoxide',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        },
    },

}

