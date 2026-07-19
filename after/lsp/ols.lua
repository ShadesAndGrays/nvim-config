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
local default_odin_exe = is_windows and "odin.exe" or "odin"

-- Define your possible Odin install roots
local odin_root = find_path({
  "C:/Program Files/Odin/dist",
  "/usr/lib/odin",
  "/home/shadow/odin",
})

-- Define your possible shared library roots
local shared_root = find_path({
  "C:/Users/shadow/odin-lib",
  "/home/shadow/dev/odin-lib",
})

-- Safely build collections only if paths are found
local collections = {}
if odin_root then
  table.insert(collections, { name = "core", path = odin_root .. "/core" })
  table.insert(collections, { name = "base", path = odin_root .. "/base" })
  table.insert(collections, { name = "vendor", path = odin_root .. "/vendor" })
end
if shared_root then
  table.insert(collections, { name = "shared", path = shared_root })
end

local default_capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  capabilities = default_capabilities,
  cmd = { "ols" },
  filetypes = { "odin" },
  root_markers = { "ols.json", ".git" },
  
  init_options = {
    -- Robust executable path check (handles Windows vs Linux/macOS)
    checker_path = odin_root and (odin_root .. "/" .. default_odin_exe) or default_odin_exe,
    checker_args = "",
    
    -- Pass our safely constructed collections table
    collections = collections,

    -- --- MODERN IDE FEATURES ---
    enable_semantic_tokens = true,
    enable_hover = true,
    enable_snippets = true,
    enable_std_references = true,
    verbose = false,
    
    -- --- FIXED: CORRECT FLAT OLS INLAY HINT KEYS ---
    enable_inlay_hints_params          = true,  -- Parameter names in tooltips & inline calls
    enable_inlay_hints_default_params  = true,  -- Renders parameters even if they fall back to defaults
    enable_inlay_hints_implicit_return = true,  -- Displays implicit result data types
    enable_inlay_hints_optional_result = true,  -- Appends results for unhandled optional return values
  },
}
