-- Open help files in a right vertical split for better UX
local group = vim.api.nvim_create_augroup("help_window_right", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    desc = "Open help window in right vertical split",
    group = group,
    pattern = "help",
    callback = function()
        vim.cmd.wincmd("L")
    end,
})

-- Trim trailing whitespace on save for all modifiable buffers
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
  desc = "Trim trailing whitespace on save",
})

-- Automatically use ctags from git root for symbol navigation (including C#, XAML, feature files)
local function get_git_root()
  local git_dir = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_dir and git_dir ~= '' then
    return git_dir
  else
    return vim.fn.getcwd()
  end
end

-- Only run ctags if it is available
local function ctags_available()
  return vim.fn.executable('ctags') == 1
end

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Update ctags symbols in git root on save (only for the saved file)",
  pattern = { "*.lua", "*.c", "*.cpp", "*.h", "*.cs", "*.xaml", "*.feature" },
  callback = function(args)
    if not ctags_available() then
      vim.notify('ctags not found in PATH. Skipping tag generation.', vim.log.levels.WARN)
      return
    end
    local root = get_git_root()
    -- Generate ctags only for the saved file (relative to git root)
    local relpath = vim.fn.fnamemodify(args.file, ':~:.')
    vim.fn.jobstart({
      "ctags", "-a", relpath
    }, {
      cwd = root,
      detach = true,
    })
    vim.opt.tags = { root .. "/tags" }
  end,
})
