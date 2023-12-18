local wk = require("which-key")
-- As an example, we will create the following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1


local mappings = {
    ["<leader>"] = {
        f = {
            name = "+file",
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
            n = { "<cmd>enew<cr>", "New File" },
        },
        t =
        {
            name = "+Telescope",
            f = {"<cmd>Telescope find_files<cr>","Find File"},
            g = {"<cmd>Telescope live_grep<cr>","Live Grep"},
            s = {"<cmd>Telescope git_status<cr>","Git Status"},
            b = {"<cmd>Telescope buffers<cr>","buffers"},


        },
        h = {
            name = "+help",
            k = {"<cmd> Telescope keymaps<cr>","List all keymaps"}


        }


    },
}
local opts = {}
wk.register(mappings,opts)

