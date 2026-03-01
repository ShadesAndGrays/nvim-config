return {{
  'akinsho/toggleterm.nvim',
  version = "*",
  config = true,
  opts = {
-- -- Use pwsh if you have it (Scoop usually installs it), otherwise powershell
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
--     shell_add_args = {
--         -- This is the magic part for Windows
--         "-NoLogo",
--         "-ExecutionPolicy", "RemoteSigned",
--         -- Force the shell to stay open and keep the path
--     },
--     -- Ensure the terminal actually sees your Scoop/Mason paths
    env = {
        PATH = vim.fn.expand("$USERPROFILE\\scoop\\shims") .. ";" .. vim.env.PATH
    }
  }
}}
