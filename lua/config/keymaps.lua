vim.g.mapleader = " "
vim.g.maplocalleader = ","


local no_opts = {}
local opts = {silent = true}
local disable = '<nop>'


local kmap = vim.keymap.set
-- old type
-- kmapv = vim.api.nvim_set_keymap

function test()
	print("test1")
end


kmap("n","<leader>`", "<cmd>lua test()<cr>",no_opts )
kmap('n', '<cr>', 'm`o<esc>``',opts)
kmap('n', '<s-cr>', 'm`o<esc>``',opts)
kmap("n", "<up>","g<up>",no_opts) -- move up even if line wrapped
kmap("n", "<down>","g<down>",no_opts) -- move down even if line wrapped
kmap("n", "k","g<up>",no_opts) -- move up even if line wrapped
kmap("n", "j","g<down>",no_opts) -- move up even if line wrapped

kmap("n", "<m-up>","<cmd> move -2 <cr>",opts)-- move line up
kmap("n","<m-down>","<cmd> move +1<cr>",opts)-- move line down
-- toggle auto save
kmap("n", "<leader>s", ":astoggle<cr>", {})
kmap("n","<leader>u", ":undotreetoggle<cr>",opts)
--kmap ("v", "<m-up>", "<cmd> '<,'> move -2 <cr>",opts) -- move selecion up
--kmap ("v", "<m-down>", "<cmd> '<,'> move +1 <cr>",opts) -- move selecion up

kmap("n", "<c-k>", "3<c-y>",opts) -- scroll down more quickly
kmap("n", "<c-j>", "3<c-e>",opts) -- scroll up more quickly

kmap("n", "<tab><tab>", "<cmd> tabnew<cr>",opts) -- create new tab
kmap("n", "<tab>p", "<cmd> tabprevious<cr>",opts) -- create new tab
kmap("n", "<tab>n", "<cmd> tabnext<cr>",opts) -- create new tab
kmap("n", "<tab>q", "<cmd> tabclose<cr>",opts) -- create new tab
-- kmap("n", "<tab>", "<c-w>", opts)

kmap("i", "jk", '<esc>',opts) --exit input mode :)

kmap('t', '<esc><esc>', [[<c-\><c-n>]], opts)


-- toggle terminal
kmap('n', '<s-c>', '<cmd>ToggleTerm direction=horizontal<cr>')
kmap('t', '<s-c>', [[<c-\><c-n><cmd>ToggleTerm direction=horizontal<cr>]])
kmap('i', '<m-c>', '<cmd>ToggleTerm direction=horizontal<cr>')

kmap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
kmap('n', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)


kmap('n',[[<leader>\]],'<cmd>belowright vsp<cr>',opts)
kmap('n',[[<leader>-]],'<cmd>belowright sp<cr>',opts)


-- kmap('n',"<leader>d",'<cmd>dashboard<cr>',opts)

kmap('n',"<leader>n","<cmd>bn<cr>",opts)
kmap('n',"<leader>p","<cmd>bp<cr>",opts)

kmap("n","<leader>ft", ":NvimTreeToggle<cr>",opts)
kmap("n","<leader>fo", "<cmd>Oil<cr>",{ desc = "open parent directory"})

-- toggle inlayhints
kmap("n","<leader>ih", "<cmd>lua toggle_in_lay()<cr>",opts)
function toggle_in_lay()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0}) 
end

function whereami()
    require('scratch-buffer').open()
    vim.api.nvim_put({vim.uv.cwd()},"",true,true)
end

kmap("n","<c-w>z", "<cmd>zenmode<cr>",opts)

-- kmap("n","<leader>fa" ,"<cmd>avantetoggle<cr>", opts)

kmap("n", "q:", "<nop>")

-- kmap("n","gd","<cmd>DiffviewOpen HEAD^<cr>",opts)
--
-- kmap("n","gx","<cmd>DiffviewClose<cr>",opts)
