
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c' , 'cpp'},
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        -- Indentation  is Experimental
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
