
local nvim_lsp = require("lspconfig")

return {

    'clangd',{
        cmd = { 'clangd', '--compile-commands-dir=build' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_dir = nvim_lsp.util.root_pattern('compile_commands.json', '.git'),
    }
}
