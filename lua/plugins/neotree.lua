return {

-- Example for neo-tree.nvim
{
  "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup()
    end,
},



}
