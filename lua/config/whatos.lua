local uname = vim.loop.os_uname()
local M = {}
_G.OS = uname.sysname
_G.IS_MAC = OS == 'Darwin'
_G.IS_LINUX = OS == 'Linux'
-- Windows sysname might vary; checking the string for 'Windows' is safer.
_G.IS_WINDOWS = OS:find('Windows') ~= nil or vim.fn.has("win64") ~= 0 or vim.fn.has("win32") ~= 0

_G.IS_WSL = IS_LINUX and uname.release:find('Microsoft') ~= nil

M.IS_MAC = _G.IS_MAC
M.IS_LINUX = _G.IS_LINUX
M.IS_WINDOWS = _G.IS_WINDOWS
M.IS_WSL = _G.IS_WSL

return M
