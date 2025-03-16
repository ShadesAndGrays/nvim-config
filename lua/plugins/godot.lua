

return {
    {
        dir = "~/Dev/code/lua/godoterm.nvim",
        name = "godoterm",
        config = function ()
            local godoterm = require("godoterm")
            godoterm.setup({
                exec = "Godot_v4.3-stable_linux.x86_64"
            })
            Kmap("n","<leader>G",godoterm.open,{desc="Godot Actions"})
        end
    },
    {'habamax/vim-godot',event = "VimEnter"}
}


