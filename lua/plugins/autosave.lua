return {{ 
    "pocco81/auto-save.nvim",
    opts = {
        trigger_events = {"InsertLeave", "TextChanged"},
        condition = function(buf)
            local fn = vim.fn
            local utils = require("auto-save.utils.data")
            local excluded_filetypes = { "lua", "gitcommit", "oil" }

            if
                fn.getbufvar(buf, "&modifiable") == 1 and
                utils.not_in(fn.getbufvar(buf, "&filetype"),  excluded_filetypes ) then
                return true -- met condition(s), can save
            end
            return false -- can't save
        end,
    }

}}
