vim.g.mapleader = " "


local no_opts = {}
local opts = {silent = true}


Kmap = vim.api.nvim_set_keymap


function Test()
	print("test1")
end


Kmap("n","<Leader>`", "<cmd>lua Test()<CR>",no_opts )
Kmap('n', '<CR>', 'm`o<Esc>``',opts)
Kmap('n', '<S-CR>', 'm`O<Esc>``',opts)
Kmap("n", "<Up>","g<Up>",no_opts) -- move up even if line wrapped
Kmap("n", "<Down>","g<Down>",no_opts) -- move down even if line wrapped
Kmap("n", "k","g<Up>",no_opts) -- move up even if line wrapped
Kmap("n", "j","g<Down>",no_opts) -- move up even if line wrapped

Kmap("n", "<M-Up>","<cmd> move -2 <CR>",opts)-- Move line up
Kmap("n","<M-Down>","<cmd> move +1<CR>",opts)-- Move line down
-- Toggle Auto save
Kmap("n", "<leader>s", ":ASToggle<CR>", {})
Kmap("n","<leader>u", ":UndotreeToggle<CR>",opts)
--Kmap ("v", "<M-Up>", "<cmd> '<,'> move -2 <CR>",opts) -- move selecion up
--Kmap ("v", "<M-Down>", "<cmd> '<,'> move +1 <CR>",opts) -- move selecion up

Kmap("n", "<C-k>", "3<C-y>",opts) -- scroll down more quickly
Kmap("n", "<C-j>", "3<C-e>",opts) -- scroll up more quickly

Kmap("n", "<Leader><tab>", "<cmd> tabnew<CR>",opts) -- create new tab
Kmap("n", "<tab>", "<C-w>", opts)

Kmap("t", "<Esc><Esc>", [[<C-\><C-n>]],opts) --exit terminal mode :)

Kmap("n", "C", "<cmd>lua FloatingTerm.toggle()<CR>", {}) --Toggle FloatingTerm

Kmap("n", "<leader>c", "<cmd>TroubleToggle <CR>",{}) -- Toggle Trouble

Kmap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
Kmap('n', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)


Kmap('n',[[<leader>\]],'<cmd>belowright vsp<CR>',opts)
Kmap('n',[[<leader>-]],'<cmd>belowright sp<CR>',opts)


Kmap('n',"<leader>d",'<cmd>Dashboard<CR>',opts)
