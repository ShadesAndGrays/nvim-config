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
local default_go_exe = is_windows and "go.exe" or "go"

-- Define your possible Go installation bin/sdk locations
local go_root = find_path({
  "C:/Program Files/Go/bin",
  "/usr/local/go/bin",
  "/usr/bin",
})

local default_capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  capabilities = default_capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  
  settings = {
    gopls = {
      -- Complete unimported packages and show documentation
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true, -- Enables robust static analysis
      directoryFilters = { "-**/node_modules", "-**/.git" },
      
      -- Control how code is analyzed
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      
      -- Inlay Hints (Requires Neovim 0.10+)
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      
      -- Codelens - adds actionable text above functions (e.g., "run test")
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
}
