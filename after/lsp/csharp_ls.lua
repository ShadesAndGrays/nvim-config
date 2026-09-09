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
local default_dotnet_exe = is_windows and "dotnet.exe" or "dotnet"

-- Define your possible .NET/MSBuild SDK paths (adjust if you use custom installs)
local dotnet_root = find_path({
  "C:/Program Files/dotnet",
  "/usr/share/dotnet",
  "/usr/lib/dotnet",
})

-- Request default Neovim client capabilities
local default_capabilities = vim.lsp.protocol.make_client_capabilities()

-- IMPORTANT: csharp_ls expects the client to declare inlayHint support explicitly
if default_capabilities.textDocument then
  default_capabilities.textDocument.inlayHint = {
    dynamicRegistration = true
  }
end

return {
  capabilities = default_capabilities,
  
  -- FIXED: Changed to the correct executable command name used by csharp_ls
  cmd = { "csharp-ls" },
  filetypes = { "cs" },
  
  -- FIXED: Integrates your literal solution and workspace fallback matching
  root_markers = { "*.sln", ".git", "project.godot" },
  
  init_options = {
    -- Required key for csharp_ls to auto-discover and load compilation graphs
    AutomaticWorkspaceInit = true,
    
    -- Passes host specific platform details down to the runtime wrapper
    dotnet_path = dotnet_root and (dotnet_root .. "/" .. default_dotnet_exe) or default_dotnet_exe,
  },
  
  settings = {
    -- csharp_ls uses a flat structure if custom settings are needed,
    -- but inlay hints are driven by the capability table modified above.
  }
}
