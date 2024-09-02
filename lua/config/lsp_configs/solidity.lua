local nvim_lsp = require("lspconfig")

return {
    'solidity',{
    cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
    filetypes = { 'solidity' },
    root_dir = nvim_lsp.util.find_git_ancestor,
    single_file_support = true,
    }
}

