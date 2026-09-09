local nvim_lsp = require("lspconfig")

return
{'vls',
{
    cmd = {'vls'},
    filetypes = {'v','vlang','vv'},
    root_dir = nvim_lsp.util.root_pattern("v.mod", ".git")
}}
