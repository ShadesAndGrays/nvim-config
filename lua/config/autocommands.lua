function hello()
    print("Hello new txt file")
end

vim.api.nvim_create_autocmd(
{"TextYankPost"},
{
    callback = function ()
        print("copy")
    end
})

local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end


local build_group = vim.api.nvim_create_augroup("UserBuildSettings", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"cpp" , "makefile", "odin" ,"c"},
    group=build_group,
    callback = function()
        vim.keymap.set("n", "<F5>", "<cmd>make<CR>", { buffer = true })
    end,
})


local nvim_tree_group = vim.api.nvim_create_augroup("NvimTreeForceJump", { clear = true })
vim.api.nvim_create_autocmd("DirChanged", {
    group=nvim_tree_group,
  callback = function()
    require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
  end,
})
