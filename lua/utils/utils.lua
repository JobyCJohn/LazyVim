local M = {}
local is_inside_work_tree = {}

M.project_files = function()
	local opts = {}

	local cwd = vim.fn.getcwd()
	if is_inside_work_tree[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		is_inside_work_tree[cwd] = vim.v.shell_error == 0
	end

	if is_inside_work_tree[cwd] then
		require("telescope.builtin").git_files(opts)
	else
		require("telescope.builtin").find_files(opts)
	end
end

M.is_windows = function()
    return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

M.multiopen = function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()

    if not vim.tbl_isempty(multi) then
        actions.close(prompt_bufnr)
        for _, selection in pairs(multi) do
            if selection.path ~= nil then
                local path = vim.fn.fnameescape(selection.path)
                if selection.lnum ~= nil then
                    vim.cmd(string.format("silent! edit +%d %s", selection.lnum, path))
                else
                    vim.cmd(string.format("silent! edit %s", path))
                end
            end
        end
    else
        actions.select_default(prompt_bufnr)
    end
end

return M
