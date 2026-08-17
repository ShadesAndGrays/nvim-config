local capabilities = require('blink.cmp').get_lsp_capabilities()

return {
  capabilities = capabilities,
  cmd = {
    "clangd",
    -- Background indexing: Allows clangd to index your code in the background
    "--background-index",
    
    -- Clang-tidy: Enables linter warnings and suggestions as you type
    "--clang-tidy",
    
    -- Compilation database directory: Helps clangd find compile_commands.json
    "--compile-commands-dir=build",
    
    -- Completion style: 'detailed' gives you parameter types and return types in completion
    "--completion-style=detailed",
    
    -- Header insertion: 'iwyu' (Include What You Use) automatically adds missing headers
    "--header-insertion=iwyu",
    
    -- Header insertion decorators: Adds a visual indicator (like a bullet) next to auto-imported headers
    "--header-insertion-decorators",
    
    -- Number of parallel workers used for background indexing (0 uses all available cores)
    "-j=4",
    
    -- Fallback style: If no .clang-format is found, default to Google, LLVM, Mozilla, etc.
    "--fallback-style=LLVM",

    -- Enable inlay hints
    "--inlay-hints",

    -- Use ram for pre-compiled headers
"--pch-storage=memory",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    ".git",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    "Makefile",
  },
  -- Explicitly defining capabilities ensures features like snippets and inlay hints work perfectly
  init_options = {
    fallbackFlags = { "-std=c++20" }, -- Default fallback standard if compile_commands.json is missing
    clangdFileStatus = true,         -- Provides status updates (e.g., "Indexing...") to your statusline
  },
}
