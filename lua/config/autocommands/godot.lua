local title = "Godot Server"

local function launch_server()

    if vim.fn.has('win32') then
        -- local port = 6004
        -- local host = '127.0.0.1'
        -- local server =  host .. ':' .. port
        vim.notify("Starting Godot Server ",  vim.log.levels.INFO, { title = title })
        vim.fn.serverstart([[\\.\pipe\godot.pipe]])
    else
        -- Handle linux hear later
        vim.fn.serverstart('godot.pipe')
    end

end

local function godot_server()
    if vim.fn.filereadable("project.godot") == 1 then
        launch_server()
    else
        vim.notify("project.godot was not found! Is this a godot project ? " .. vim.fn.getcwd(), vim.log.levels.WARN)
    end
end

vim.api.nvim_create_user_command('GodotServer', godot_server, {})
vim.api.nvim_create_user_command('GodotServerForce', launch_server, {})
