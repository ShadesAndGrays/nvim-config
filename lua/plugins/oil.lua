return {{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
      keymaps = {
          ["<leader>h"] = { "actions.parent", mode = "n" },
          ["<leader>r>"] = "actions.refresh",
          ["<leader>l"] = { "actions.select", mode = "n" },
          ["gcd"] = { "actions.cd", mode = "n" },
          ["<esc><esc>"] = { "actions.close", mode = "n" },
      }
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}}
