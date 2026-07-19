vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    { src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.*") },
})

--
local dap = require('dap')

local dapview = require("dap-view")
dapview.setup()
--
-- dapui.setup({
--     layouts = {
--         {
--             elements = {
--                 -- { id = "repl",    size = 0.5 },
--                 { id = "console", size = 0.5 },
--             },
--             position = "bottom",
--             size = 10,
--         },
--     },
-- })
--
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = {
        "--interpreter=dap",
        "--eval-command", "set print pretty on",
    }
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "gdb",
        request = "launch",
        program = function()
            local path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
            return path:gsub("\\", "/")
        end,
        cwd = function()
            return vim.fn.getcwd():gsub("\\", "/")
        end,
        stopAtBeginningOfMainSubprogram = true,
    },
}

-- Very specific filtering for gdb
local notify_plugin = require("notify")

vim.notify = function(msg, level, opts)
    if type(msg) == "string"
        and msg:match("exited with 1")
        and msg:match("adapter")
        and msg:match("gdb") then
        return
    end
    notify_plugin(msg, level, opts)
end

local kmap = vim.keymap.set

kmap('n', '<leader>gdc', function()
    dap.continue()
    dapview.open()
end, { desc = 'Debugger: Continue Debugging' })
kmap('n', '<leader>gdb', dap.toggle_breakpoint, { desc = 'Debugger: Toggle Breakpoint' })
kmap('n', '<leader>gdt', function()
    dap.terminate()
    dapview.close()
end, { desc = 'Debugger: Stop' })

kmap('n', '<leader>gdu', function()
    dapview.toggle()
end, { desc = 'Debugger: UI toggle ' })

-- Define the breakpoint sign appearance
vim.fn.sign_define("DapBreakpoint", {
    text = "●",
    texthl = "DiagnosticError", -- Uses your theme's default red error color
    linehl = "",
    numhl = "",
})

-- Optional: You can also customize other debugging states while you're at it!
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticHint", linehl = "Visual" })

-- dap.listeners.before.attach.dapui_config = function() dapui.open({ reset = true }) end
-- dap.listeners.before.launch.dapui_config = function() dapui.open({ reset = true }) end
-- dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
-- dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
--
dap.listeners.after.event_terminated['dapui_config'] = function()
    dap.terminate()
    dapview.close()
end
dap.listeners.after.event_exited['dapui_config'] = function()
    dap.terminate()
    dapview.close()
end


local function map_dap_or_move(key, dap_fn, default_key)
    vim.keymap.set('n', key, function()
        local dap = package.loaded['dap']
        -- Check if a debugging session exists and is active
        if dap and dap.session() then
            dap_fn()
        else
            -- Fall back to the default Neovim movement behavior
            vim.cmd('normal! ' .. default_key)
        end
    end, { desc = 'DAP conditional mapping for ' .. key })
end

-- Setup the dynamic bindings
map_dap_or_move('<Up>', function() require('dap').continue() end, 'k')
map_dap_or_move('<Down>', function() require('dap').step_over() end, 'j')
map_dap_or_move('<Right>', function() require('dap').step_into() end, 'l')
map_dap_or_move('<Left>', function() require('dap').step_out() end, 'h')
