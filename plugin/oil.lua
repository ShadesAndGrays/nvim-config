vim.pack.add({
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/stevearc/oil.nvim.git'
})

require("oil").setup({
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },


      keymaps = {
          ["<leader>h"] = { "actions.parent", mode = "n" },
          ["<leader>r>"] = "actions.refresh",
          ["<leader>l"] = { "actions.select", mode = "n" },
          ["gcd"] = { "actions.tcd", mode = "n" },
          ["<esc><esc>"] = { "actions.close", mode = "n" },
      }

})


