print("Hello from key maps")

vim.g.mapleader = " "


local no_opts = {}
local opts = {silent = true}


kmap = vim.api.nvim_set_keymap


function test()
	print("test1")
end

kmap("n","<Leader>`", "<cmd>lua test()<CR>",no_opts )
kmap("n", "<Leader><Enter>", "<cmd> exe 'normal a'.nr2char(getchar())<CR><CR>",opts) -- remmaping enter to neline in normalmode

kmap("n", "<Up>","g<Up>",no_opts) -- move up even if line wrapped
kmap("n", "<Down>","g<Down>",no_opts) -- move down even if line wrapped

kmap("n", "<M-Up>","<cmd> move -2 <CR>",opts)-- Move line up
kmap("n","<M-Down>","<cmd> move +1<CR>",opts)-- Move line down


-- kmap ("v", "<M-Up>", "<cmd> '<,'> move -2 <CR>",opts) -- move selecion up
-- kmap ("v", "<M-Down>", "<cmd> '<,'> move +1 <CR>",opts) -- move selecion up

kmap("n", "<Leader>t", "<cmd>tabn<CR>", opts)
kmap("n", "<Leader>T", "<cmd>tabp<CR>",opts)

kmap("n", "<C-UP>", "3<C-y>",opts) -- scroll down more quickly
kmap("n", "<C-DOWN>", "3<C-e>",opts) -- scroll up more quickly

kmap("n", "<Leader><tab>", "<cmd> tabnew<CR>",opts) -- create new tab
kmap("n", "<tab>", "<C-w>", opts)
