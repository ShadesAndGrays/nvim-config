
local nvim_lsp = require("lspconfig")

return {

    'cmake',{
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = nvim_lsp.util.root_pattern('CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake'),
    }
}
