-- local nvim_lsp = require("lspconfig")
return {

    'rubocop',{
        cmd = { "bundle", "exec rubocop --lsp" },
        filetypes = {'rb'}
        -- root_dir = nvim_lsp.util.root_pattern('compile_commands.json', '.git'),
    }
}

--[[ return {

    'fortls',{
        cmd = { 'fortls' },
        filetypes = { 'f03', 'for', 'f' },
    }
} ]]
