local M = {}

M.setup = function()
    if vim.g.neovide then
        vim.g.neovide_cursor_vfx_mode = "railgun"
        vim.g.neovide_fullscreen = false
        if vim.fn.argc() > 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            vim.fn.chdir(vim.fn.expand(vim.fn.argv(0)))
        else
            vim.fn.chdir(vim.fn.expand("~"))
        end
    end
end


return M
