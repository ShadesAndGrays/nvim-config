return { {
    "BlinkResearchLabs/blink-edit.nvim",
    config = function()
        require("blink-edit").setup({
            llm = {
                provider = "sweep",
                backend = "ollama",
                url = "http://172.18.48.1:11434",
                model = "sweepai/sweep-next-edit",
            },
            context = {
                lsp_enabled = true,
                treesitter_enabled = true,
            },
            lsp = {
                enabled = true, -- Fetch LSP references for cursor symbol
                max_definitions = 2, -- Max definition locations
                max_references = 2, -- Max reference locations
                timeout_ms = 100, -- LSP request timeout
            },

            normal_mode = {
                enabled = true,
                debounce_ms = 400,

            }
        })
    end,
} }
