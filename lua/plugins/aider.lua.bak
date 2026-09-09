return {
  {
    "aweis89/aider.nvim",
    dependencies = {
      -- required for core functionality
      "akinsho/toggleterm.nvim",

      -- for fuzzy file `/add`ing functionality ("ibhagwan/fzf-lua" supported as well)
      "nvim-telescope/telescope.nvim",

      -- Optional, but great for diff viewing and after_update_hook integration
      "sindrets/diffview.nvim",

      -- Optional but will show aider spinner whenever active
      "folke/snacks.nvim",

      -- Only if you care about using the /editor command
      "willothy/flatten.nvim",
    },
    lazy = false,
    opts = {
      -- Auto trigger diffview after Aider's file changes
      after_update_hook = function()
        require("diffview").open({ "HEAD^" })
      end,
    },
    keys = {
      {
        "<leader>as",
        "<cmd>AiderSpawn<CR>",
        desc = "Toggle Aidper (default)",
      },
      {
        "<leader>a<space>",
        "<cmd>AiderToggle<CR>",
        desc = "Toggle Aider",
      },
      {
        "<leader>af",
        "<cmd>AiderToggle float<CR>",
        desc = "Toggle Aider Float",
      },
      {
        "<leader>av",
        "<cmd>AiderToggle vertical<CR>",
        desc = "Toggle Aider Float",
      },
      {
        "<leader>al",
        "<cmd>AiderAdd<CR>",
        desc = "Add file to aider",
      },
      {
        "<leader>ad",
        "<cmd>AiderAsk<CR>",
        desc = "Ask with selection",
        mode = { "v", "n" },
      },
      {
        "<leader>am",
        desc = "Change model",
      },
      {
        "<leader>ams",
        "<cmd>AiderSend /model sonnet<CR>",
        desc = "Switch to sonnet",
      },
      {
        "<leader>amh",
        "<cmd>AiderSend /model haiku<CR>",
        desc = "Switch to haiku",
      },
      {
        "<leader>amg",
        "<cmd>AiderSend /model gemini/gemini-exp-1206<CR>",
        desc = "Switch to haiku",
      },
      {
        "<C-x>",
        "<cmd>AiderToggle<CR>",
        desc = "Toggle Aider",
        mode = { "i", "t", "n" },
      },
      -- Helpful mappings to utilize to manage aider changes
      {
        "<leader>ghh",
        "<cmd>Gitsigns change_base HEAD^<CR>",
        desc = "Gitsigns pick reversals",
      },
      {
        "<leader>dvh",
        "<cmd>DiffviewOpen HEAD^<CR>",
        desc = "Diffview HEAD^",
      },
      {
        "<leader>dvo",
        "<cmd>DiffviewOpen<CR>",
        desc = "Diffview",
      },
      {
        "<leader>dvc",
        "<cmd>DiffviewClose!<CR>",
        desc = "Diffview close",
      },
    },
  },
}
