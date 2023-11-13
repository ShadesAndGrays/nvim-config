return 
{
	{ 
		"williamboman/mason.nvim",
		config = function()
			Mason = require("mason")
--			Mason.load()
			Mason.setup{}
		end
},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
	 ensure_installed = { "lua_ls", "rust_analyzer" ,"clangd"}	
		end
	},
	{"neovim/nvim-lspconfig"},
}
