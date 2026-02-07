vim.g.mapleader = " "
vim.g.maplocalleader = ","


local no_opts = {}
local opts = {silent = true}
local disable = '<nop>'


Kmap = vim.keymap.set
-- old type
-- Kmapv = vim.api.nvim_set_keymap

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
-- Kmap("n", "<tab>", "<C-w>", opts)

Kmap("i", "jk", '<Esc>',opts) --exit input mode :)

Kmap('t', '<Esc><Esc>', [[<C-\><C-n>]], opts)
Kmap('t', 'jk', [[<C-\><C-n>]], opts)


-- Toggle Terminal
if not vim.g.neovide then
    -- Currently substituing back tick with ^ cause i'm opperating through powershell which's been configured to send "\u001e" (windows ^ , linux `)
    ---- Toggle in Normal Mode, Terminal Mode and Insert Mode
    vim.keymap.set('n', '<C-^>', '<cmd>ToggleTerm<cr>')
    vim.keymap.set('t', '<C-^>', [[<C-\><C-n><cmd>ToggleTerm<cr>]])
    vim.keymap.set('i', '<C-^>', '<cmd>ToggleTerm<cr>')
else
    vim.keymap.set('n', '<C-`>', '<cmd>ToggleTerm<cr>')
    vim.keymap.set('t', '<C-`>', [[<C-\><C-n><cmd>ToggleTerm<cr>]])
    vim.keymap.set('i', '<C-`>', '<cmd>ToggleTerm<cr>')
end



-- Toggle 
Kmap('n',"<leader>dd",'<cmd>Trouble diagnostics toggle<CR>',opts)


Kmap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
Kmap('n', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)


Kmap('n',[[<leader>\]],'<cmd>belowright vsp<CR>',opts)
Kmap('n',[[<leader>-]],'<cmd>belowright sp<CR>',opts)


-- Kmap('n',"<leader>d",'<cmd>Dashboard<CR>',opts)

Kmap('n',"<leader>n","<cmd>bn<CR>",opts)
Kmap('n',"<leader>p","<cmd>bp<CR>",opts)

Kmap("n","<leader>ft", ":NvimTreeToggle<CR>",opts)
Kmap("n","<leader>fo", "<CMD>Oil<CR>",{ desc = "Open Parent Directory"})

-- Toggle inlayhints
Kmap("n","<leader>ih", "<cmd>lua TOGGLE_IN_LAY()<CR>",opts)
function TOGGLE_IN_LAY()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0}) 
end

function WHEREAMI()
    require('scratch-buffer').open()
    vim.api.nvim_put({vim.uv.cwd()},"",true,true)
end

Kmap("n","<C-w>z", "<cmd>ZenMode<CR>",opts)

Kmap("n", "q:", "<nop>")
