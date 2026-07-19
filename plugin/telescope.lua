vim.pack.add({

	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim"
})


local telescope = require('telescope')

local actions = require("telescope.actions")
telescope.setup({
defaults = {
    mappings = {
	i = { -- Insert mode
	    ["<C-j>"] = actions.move_selection_next,
	    ["<C-k>"] = actions.move_selection_previous,
	    ["<C-d>"] = actions.delete_buffer, -- Delete buffer from within picker

	    -- Scroll the PREVIEW window
	    ["<C-i>"] = actions.preview_scrolling_up,
	    ["<C-o>"] = actions.preview_scrolling_down,
	},
	n = { -- Normal mode
	    ["q"] = actions.close,
	    ["<C-d>"] = actions.delete_buffer, -- Delete buffer from within picker

	    -- Scroll preview in normal mode too
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

--telescope.load_extension('fzf')
--telescope.load_extension('project')
--telescope.load_extension('zoxide')

local builtin = require('telescope.builtin')
local kmap = vim.keymap.set

-- Kmap('n', '<leader>fg', builtin.live_grep, {}) -- replaced with multigrep
kmap('n', '<leader>fcc',
function ()
builtin.find_files{
    cwd = vim.fn.stdpath('config')
}
end
, { desc = "Config files"}) -- open telescope in configuration directory

kmap('n', '<leader>fpp',

function ()
builtin.find_files{
    cwd = vim.fs.joinpath(vim.fn.stdpath("data"),"lazy")
}
end
, { desc = "Plugin files" }) -- open telescope in configuration directory

kmap('n', '<leader>ff', builtin.find_files, {desc = "Telescope find files"})
kmap('n', '<leader>fb', builtin.buffers, {desc = "Telescope find buffers"})
kmap('n', '<leader>fh', builtin.help_tags, {desc = "Telescope find help"})
kmap('n', '<leader>fs', builtin.spell_suggest, {desc = "Telescope spell suggest"}) -- I mess up a lot
kmap('n', '<leader>fk', builtin.keymaps, {desc = "Telescope find keymap"})
kmap('n', '<leader>fcm', builtin.commands, {desc = "Telescope find commands"}) -- I am a god now
kmap('n', '<leader>fch', builtin.command_history, {desc = "Telescope find previuos commands commands"}) -- 
--kmap('n', '<leader>fp', telescope.extensions.project.project, {desc = "Telescope Project View"})
--kmap("n", "<leader>fz", telescope.extensions.zoxide.list, {desc = "Find Recent directories"})
kmap('n','<leader>mk',function() require ("config.telescope.make").picker() end,{desc = "Telescope MakefileTargets"})


require('config.telescope.multigrep').setup()


