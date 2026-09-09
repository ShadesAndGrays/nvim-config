

if vim.b.user_python_config then
    return
end

vim.b.user_python_config = true
vim.notify("Loaded python")

-- 1. Buffer-local options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- 2. Buffer-local keymaps
vim.keymap.set("n", "<leader>r", "<cmd>term python3 %<CR>", {
    buffer = true,
    desc = "Run Python script in terminal",
})


