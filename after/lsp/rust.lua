local capabilities = require('blink.cmp').get_lsp_capabilities()

return {
    capabilities = capabilities,
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-toolchain", "rust-toolchain.toml", ".git" },

    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
            },
            standalone = true,
            -- --- PERFORMANCE & WORKSPACE ---
            -- Background compiler check setup
            check = {
                command = "check",
                extraArgs = { "--target-dir", "target/analyzer" }, -- Keeps target directory unlocked during manual cargo builds
            },
            cargo = {
                allFeatures = true,
                buildScripts = {
                    enable = true, -- Replaces deprecated loadOutDirsFromCheck; builds procedural macros / build.rs
                },
            },
            procMacro = {
                enable = true,
            },

            -- --- INLAY HINTS CONFIGURATION ---
            inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true },
                closureReturnTypeHints = { enable = "never" },
                lifetimeElisionHints = { enable = "never" },
                parameterHints = { enable = "always" }, -- Note: renamed from paramNameHints in modern RA schema
                renderColons = true,
                typeHints = {
                    enable = true,
                    hideClosureInitialization = false,
                    hideNamedConstructor = false,
                },
            },
        },
    },
}
