return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },

    config = function()
         require('telescope').setup({
        --     defaults = {
        --         -- Default configuration for telescope goes here:
        --         -- config_key = value,
        --         mappings = {
        --             i = {
        --                 -- map actions.which_key to <C-h> (default: <C-/>)
        --                 -- actions.which_key shows the mappings for your picker,
        --                 -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        --                 ["<C-h>"] = "which_key"
        --             }
        --         }
        --     },
            pickers = {
                find_files = {
                    theme = "ivy",
                    hidden = false,
                },
                buffers = {
                    theme = "cursor",
                },
                spell_suggest = {
                    theme = "cursor",
                },
                keymaps = {
                    theme = "dropdown",
                }
            },
        })
        local builtin = require('telescope.builtin')

        Kmap('n', '<leader>fg', builtin.live_grep, {})
        Kmap('n', '<leader>fcc',
        function ()
            builtin.find_files{
                cwd = vim.fn.stdpath('config')
            }
        end
        , {}) -- open telescope in configuration directory
        Kmap('n', '<leader>ff', builtin.find_files, {desc = "Telescope find files"})
        Kmap('n', '<leader>fb', builtin.buffers, {desc = "Telescope find buffers"})
        Kmap('n', '<leader>fh', builtin.help_tags, {desc = "Telescope find help"})
        Kmap('n', '<leader>fs', builtin.spell_suggest, {desc = "Telescope spell suggest"}) -- I mess up a lot
        Kmap('n', '<leader>fk', builtin.keymaps, {desc = "Telescope find keymap"})
        Kmap('n', '<leader>fco', builtin.commands, {desc = "Telescope find commands"}) -- I am a god now

    end
}

