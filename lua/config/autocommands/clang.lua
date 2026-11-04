local cpp_markers = { "CMakeLists.txt" }

local function is_empty(s)
    return s == nil or s == ''
end

local function path_contains(path)
    return vim.env.PATH:find(path, 1, true)
end


local function add_path(path)
    if path_contains(path) then
        -- nothing to add
        return false
    end
    vim.env.PATH = path .. ";" .. vim.env.PATH
    vim.env.MSYSTEM = "CLANG64"

    -- success
    return true
end

local function enable_clang64()
    -- get env from path
    local clang_env = vim.env["CLANG_ENV"]

    -- if not empty load
    if not is_empty(clang_env) then
        return add_path(clang_env)
    end

    -- always return false if env is empty
    return false
end

local function try_activate()
    if vim.fs.root(vim.fn.getcwd(), cpp_markers) then
            local enabled = enable_clang64()
            if enabled then
                vim.notify("Detected Clang Environment")
            end
        end
end


vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    pattern = {"*"},
    callback =  function() try_activate() end
})

vim.api.nvim_create_user_command("CheckClangEnv", try_activate, {})
