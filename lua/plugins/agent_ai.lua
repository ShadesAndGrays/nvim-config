return { {

    "yetone/avante.nvim",
    event        = "VeryLazy",
    version      = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts         = {
        -- add any opts here
        mode                      = "legacy",
        -- this file can contain specific instructions for your project
        instructions_file         = "avante.md",

        provider                  = "lmstudio",
        providers                 = {

            ["lmstudio"] = {
                __inherited_from = "openai",
                api_key_name = "",
                endpoint = "http://127.0.0.1:1234/v1",
                model = "qwen2.5-coder-7b-instruct",
            }
        },
        auto_suggestions_provider = "lmstudio",
        behaviour                 = {
            auto_suggestions = true, -- Re-enable for the 7B model
            minimize_diff = true,
            auto_apply_diff_after_generation = false,
        }
    },
    dependencies = {

        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",

        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
    }
} }
