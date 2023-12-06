return{
    {
        "williamboman/mason.nvim",
        init = function()
            -- INIT
            require("mason").setup(
            {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }) -- starting LSP Manager


        end
    },
    {   "williamboman/mason-lspconfig.nvim",
    init = function()
        require("mason-lspconfig").setup()
    end
}
,

{
    "neovim/nvim-lspconfig"
},
{"ms-jpq/coq_nvim",
    branch = 'coq',
}, 
{"ms-jpq/coq.artifacts", branch =  'artifacts'},

    {"ms-jpq/coq.thirdparty" , branch =  '3p'}
}


