
local M = {}

--- Check if the current OS is Windows
function M.is_windows()
    return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
end


--- Configure Neovim to use PowerShell as the default shell on Windows.
--  This should be called from your platform-specific config (e.g., config/platform.lua)
function M.setup_windows_shell()
    local opt = vim.opt
    if M.is_windows() and vim.fn.executable("pwsh") == 1 then
        opt.shell = "pwsh"
        opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::UTF8"
        opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait; exit $LastExitCode"
        opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
        opt.shellquote = ""
        opt.shellxquote = ""
    end
end

return M
