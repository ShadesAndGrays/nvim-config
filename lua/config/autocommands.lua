function hello()
    print("Hello new txt file")
end

--[[ vim.api.nvim_create_autocmd({
"BufEnter","BufRead"
},
{pattern="*.txt",
callback=hello}
) ]]

vim.api.nvim_create_autocmd(
{"TextYankPost"},
{
    callback = function ()
        print("copy")
    end
})
