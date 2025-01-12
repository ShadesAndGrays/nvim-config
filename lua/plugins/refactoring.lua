return{  {
    "ThePrimeagen/refactoring.nvim",
    lazy = false,
    cmd = "Refactor",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("refactoring").setup({

            prompt_func_return_type = {

                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
            prompt_func_param_type = {

                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
            show_success_message = true,
        })
        -- load refactoring Telescope extension
        require("telescope").load_extension("refactoring")

        vim.keymap.set(
        {"n", "x"},
        "<leader>rr",
        function() require('telescope').extensions.refactoring.refactors() end
        )

    end,
},}
