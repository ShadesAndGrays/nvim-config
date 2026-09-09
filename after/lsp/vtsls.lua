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
local default_node_exe = is_windows and "node.exe" or "node"

-- Define your possible Node runtime locations (useful if using local nvm/fnm managers)
local node_root = find_path({
  "C:/Program Files/nodejs",
  "/usr/bin",
  "/usr/local/bin",
})

local default_capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  capabilities = default_capabilities,
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  
  settings = {
    -- vtsls handles configurations cleanly via native VS Code-style tables
    vtsls = {
      autoUseWorkspaceTsdk = true, -- Auto-load local project node_modules/typescript if present
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },

    javascript = {
      inlayHints = {
        parameterNames = { enabled = "literals" }, -- "none" | "literals" | "all"
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },

    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" }, -- "none" | "literals" | "all"
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
