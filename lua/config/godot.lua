local title = "Godot Server"
local function godot_server()
    if vim.fn.filereadable("project.godot") == 1 then
        if vim.fn.has('win32') then
            local port = 6004
            local host = '127.0.0.1'
            local server =  host .. ':' .. port
            vim.fn.serverstart(server)

            vim.notify("Starting Godot Server on " .. server, vim.log.levels.INFO, { title = title })
        else
            -- Handle linux hear later
            vim.notify("Godot server command not has only been implemented on windows", vim.log.levels.ERROR)
        end
    else
        vim.notify("project.godot was not found! Is this a godot project ? " .. vim.fn.getcwd(), vim.log.levels.WARN)
    end
end

vim.api.nvim_create_user_command('GodotServer', godot_server, {})
