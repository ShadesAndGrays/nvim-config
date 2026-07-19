local M = {}

function M.picker()
    local found = vim.fs.find(function(name, path)
        local lower = name:lower()
        return lower == "makefile"
    end, {
        path = vim.uv.cwd(),
        limit = 1,
        type = 'file'
    })

    if #found == 0 then
        vim.notify('No makefile found in the current directory', vim.log.levels.WARN)
        return
    end

    local makefile = found[1]

    -- if vim.fn.filereadable(makefile) == 0 then
    --     vim.notify('No makefile found in the current directory', vim.log.levels.WARN)
    --     return
    -- end

    local targets = {}

    for line in io.lines(makefile) do
        local target = line:match("^([%w_-]+):")
        if target and not target:match("^%.") then
            table.insert(targets, target)
        end
    end

    if #targets == 0 then
        vim.notify("No valid targets found in makefile", vim.log.levels.INFO)
        return
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- Import toggleterm terminal class
    local Terminal = require("toggleterm.terminal").Terminal

    pickers.new({}, {
        prompt_title = "Makefile Targets",
        finder = finders.new_table({ results = targets }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local target = selection[1]

                local make_term = Terminal:new({
                    cmd = "make " .. target,
                    direction = "vertical",
                    close_on_exit = false,
                    start_in_insert = true, -- Forces insert mode automatically
                    hidden = false,
                })

                make_term:toggle()
            end)
            return true
        end,
    }):find()
end

return M
