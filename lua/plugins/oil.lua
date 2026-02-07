return {{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
      keymaps = {
          ["h"] = { "actions.parent", mode = "n" },
          ["<C-r>"] = "actions.refresh",
          ["l"] = { "actions.select", mode = "n" },
      }
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}}
