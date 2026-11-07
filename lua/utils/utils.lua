local M = {}

function M.is_windows()
  return vim.fn.has("win32") == 1
end

function M.setup_windows_shell()
  if not M.is_windows() or vim.fn.executable("pwsh") ~= 1 then
    return
  end
  local o = vim.o
  o.shell = "pwsh"
  o.shellcmdflag = "-NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command "
    .. "[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();"
    .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
    .. "$PSStyle.OutputRendering='plaintext';"
    .. "Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
  o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  o.shellquote = ""
  o.shellxquote = ""
end

function M.setup_windows_clipboard()
  if vim.fn.has("wsl") ~= 1 then
    return
  end

  local pwsh = "/mnt/c/Program Files/PowerShell/7/pwsh.exe"
  if vim.fn.executable(pwsh) ~= 1 then
    vim.notify(
      "WSL clipboard: Windows PowerShell 7 not found at " .. pwsh,
      vim.log.levels.WARN
    )
    return
  end

  local encoding =
    "[Console]::InputEncoding = [Console]::OutputEncoding = "
    .. "[System.Text.UTF8Encoding]::new(); "
    .. "$ErrorActionPreference = 'Stop'; "

  local function command(script)
    return {
      pwsh,
      "-NoLogo",
      "-NoProfile",
      "-NonInteractive",
      "-Command",
      encoding .. script,
    }
  end

  local copy = command("Set-Clipboard -Value ([Console]::In.ReadToEnd())")
  local paste = command("[Console]::Write((Get-Clipboard -Raw))")

  vim.g.clipboard = {
    name = "Windows clipboard through PowerShell",
    copy = {
      ["+"] = copy,
      ["*"] = copy,
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
    cache_enabled = 0,
  }

  vim.opt.clipboard = "unnamedplus"
end

return M