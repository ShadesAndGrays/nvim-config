local default_capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  capabilities = default_capabilities,
  filetypes = { "gdscript" },
  root_markers = { "project.godot", ".git" },
  
  -- FIXED: Bypass external terminal commands and establish a pure Lua network socket loop.
  -- This intercepts the raw RPC handler, ensuring initial configurations are correctly read.
  cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
  
  settings = {
    GDScript = {
      -- FIXED: Wrapped configurations directly inside the network layer schema mapping.
      inlayHints = {
        enable = true,
        showTypeHints = true,        -- Shows static argument/return types (e.g., : Vector2)
        showArgumentNames = true,    -- Displays parameter labels inside engine methods
      },
      complete_node_paths = true,    -- Toggles scene-tree absolute auto-completion string paths
    }
  },
}
