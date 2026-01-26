return{

    cmd = {'lua-language-server'},
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'), -- Use appropriate path separator
            },
            completion = {
                callSnippet = 'Replace',
            },
            diagnostics = {
                enable = true,
                globals = { 'vim', 'use' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                maxPreload = 10000,
                preloadFileSize = 10000,
            },
            telemetry = { enable = false },
        },
    },
}
