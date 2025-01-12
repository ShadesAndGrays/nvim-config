-- local buf_num = vim.api.nvim_create_buf(false,true)

-- vim.api.nvim_command("set number")
vim.api.nvim_create_user_command('Rename', 'lua vim.lsp.buf.rename()', {})
-- vim.api.nvim_open_win(buf_num, true,{relative='cursor', row=1, col=0, width=20, height=20, anchor='NW'})

-- local buffs  = vim.api.nvim_list_bufs()
--
-- local output = vim.inspect(buffs)
--
-- print(output)


local function place_text()
    local pos = vim.api.nvim_win_get_cursor(0)
    local x =  pos[1]
    local y =  pos[2]
    vim.api.nvim_buf_set_text(0,x-1,y-1,x-1,y-1,{vim.inspect(pos)})
end


-- Kmap('n',"<leader>qq", place_text,{})

-- Kmap('n',"<leader>r<CR>","<cmd> luafile $PWD/% <CR>")
Kmap('n',"<leader>R","<cmd> Rename <CR>")


