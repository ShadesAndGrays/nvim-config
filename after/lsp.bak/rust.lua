-- Helper function to find the first existing path from a list
local function find_path(paths)
  for _, path in ipairs(paths) do
    if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
      return path
    end
  end
  return nil
end

-- Detect OS for correct executable extensions and default fallbacks
local is_windows = vim.fn.has("win32") == 1
local default_cargo_exe = is_windows and "cargo.exe" or "cargo"

-- Define your possible Rust/Cargo installation locations
local rust_root = find_path({
  "C:/Users/shadow/.cargo/bin",
  "C:/Program Files/Rust/bin",
  "/home/shadow/.cargo/bin",
  "/usr/bin",
})

local default_capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  capabilities = default_capabilities,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-toolchain", "rust-toolchain.toml", ".git" },
  
  settings = {
    ["rust-analyzer"] = {
      -- --- PERFORMANCE & WORKSPACE ---
      -- Uses cargo check in the background for live compiler errors
      checkOnSave = {
        command = "check",
        extraArgs = { "--target-dir", "target/analyzer" }, -- Avoid locking the main target folder
      },
      cargo = {
        allFeatures = true,      -- Compiles with all feature flags enabled
        loadOutDirsFromCheck = true, -- Crucial for parsing build.rs generated code
      },
      procMacro = {
        enable = true, -- Enables analysis inside macros like tokio::main or serde
      },
      
      -- --- ROBUST INLAY HINTS CONFIGURATION ---
      inlayHints = {
        bindingModeHints = { enable = false },
        chainingHints = { enable = true },            -- Type hints at the end of method chains
        closingBraceHints = { enable = true },         -- Shows context names at closing brackets
        closureReturnTypeHints = { enable = "never" },
        lifetimeElisionHints = { enable = "never" },
        paramNameHints = { enable = "always" },        -- Shows parameter labels in function calls
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

