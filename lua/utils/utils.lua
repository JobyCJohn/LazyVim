local M = {}

M.is_windows = function()
    return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
end

return M
