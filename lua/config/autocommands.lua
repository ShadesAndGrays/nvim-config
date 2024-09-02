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
