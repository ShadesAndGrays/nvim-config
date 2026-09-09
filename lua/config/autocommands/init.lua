require("config.autocommands.godot")
require("config.autocommands.notify")
-- local telescope = require("telescope")
-- local plenary = require("plenary")


-- lazy load plugins
vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*", -- Match all buffers (or specify a pattern like "*.lua" or "*.py")
    callback = function()
        require("plugins.lualine")
        require("plugins.lsp")
        require("plugins.dap")
        require("plugins.trouble")
        require("plugins.comments")
        require("plugins.autosave")
        require("plugins.git")
        require("plugins.brackets")
        require("plugins.treesitter")
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*", -- Match all buffers (or specify a pattern like "*.lua" or "*.py")
    callback = function()
        require("plugins.edgy")
        require("plugins.toggleterm")
        require("plugins.dashboard")
        require("plugins.flatten")
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*", -- Match all buffers (or specify a pattern like "*.lua" or "*.py")
    callback = function()
        require("plugins.oil")
        require("plugins.telescope")
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md", -- Match all buffers (or specify a pattern like "*.lua" or "*.py")
    callback = function()
        require("plugins.readme")
    end,
})

_G.reload_config_cache = ""

function ReloadMyConfig()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local reload = require("plenary.reload")

    local unique_headers = {}

    for name, _ in pairs(package.loaded) do
        if not name:match("^vim") and not name:match("^lsp") then
            table.insert(unique_headers, name)
            local header = vim.split(name, '[%.%-]')[1]
            if header and #header > 0 then
                unique_headers[header] = true
            end
        end
    end

    local reduced_modules = vim.tbl_keys(unique_headers)
    -- table.sort(reduced_modules)

    -- launch telescope
    pickers.new({}, {
        prompt_title = "Reload Modules",
        finder = finders.new_table({ results = reduced_modules }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if not selection then return end

                local target = selection[1]

                vim.notify("Reloading: " .. target, vim.log.levels.INFO)
                reload.reload_module(target, true)
                vim.cmd("source $MYVIMRC")
            end)
            return true
        end,
    }):find()
end

vim.api.nvim_create_user_command("ReloadConfig", ReloadMyConfig, {})

--vim.cmd([[au BufNewFile,BufRead *.v set filetype=vlang]])
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.v",
    command = "set filetype=vlang",
})
