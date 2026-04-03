-- Helper function to find the first existing path from a list
local function find_path(paths)
  for _, path in ipairs(paths) do
    if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
      return path
    end
  end
  return nil -- Return nil if none exist
end

-- Define your possible Odin install roots
local odin_root = find_path({
  "C:/Program Files/Odin/dist", -- Windows Default
  "/usr/lib/odin",              -- Linux Default
  "/home/shadow/odin",          -- Custom Linux path
})

-- Define your possible shared library roots
local shared_root = find_path({
  "C:/Users/shadow/odin-lib",
  "/home/shadow/dev/odin-lib",
})


return {
    cmd = { "ols" },
    init_options = {
        -- Automatically use the full path to odin.exe if found, else fallback to "odin"
        checker_path = odin_root and (odin_root .. "/odin.exe") or "odin",

        checker_args = "",
        collections = {
            { name = "core",   path = odin_root .. "/core" },
            { name = "base",   path = odin_root .. "/base" },
            { name = "vendor", path = odin_root .. "/vendor" },
            { name = "shared", path = shared_root },
        }
    },
    filetypes = { "odin" },
    root_markers = { "ols.json", ".git", "*.odin" },
}
