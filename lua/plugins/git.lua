return {
  {
    "kdheepak/lazygit.nvim",
    enabled = not vim.g.vscode,
    cmd = { "LazyGit", "LazyGitCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (Current File Repository)" },
      { "<leader>gG", "<cmd>LazyGit<cr>", desc = "LazyGit (cwd)" },
    },
  },
  {
    "sindrets/diffview.nvim",
    enabled = not vim.g.vscode,
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          winbar_info = true,
        },
      },
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
      },
      hooks = {
        view_opened = function(view)
          view.emitter:on("file_open_post", function(_, entry)
            if entry.kind ~= "working" then
              return
            end
            vim.schedule(function()
              if view.cur_entry ~= entry or vim.api.nvim_get_current_tabpage() ~= view.tabpage then
                return
              end
              local window = view.cur_layout:get_main_win()
              if not window or not window:is_valid()
                or window.file.rev.type ~= require("diffview.vcs.rev").RevType.LOCAL then
                return
              end
              window:focus()
              vim.cmd("diffupdate")
              local first_change = 1
              for line = 1, vim.api.nvim_buf_line_count(0) do
                if vim.fn.diff_hlID(line, 1) ~= 0 or vim.fn.diff_filler(line) > 0 then
                  first_change = line
                  break
                end
              end
              vim.api.nvim_win_set_cursor(window.id, { first_change, 0 })
              vim.cmd("normal! zvzz")
            end)
          end)
        end,
      },
    },
    keys = {
      { "<leader>gu", "<cmd>DiffviewOpen<cr>", desc = "Diffview (Unstaged Changes)" },
      { "<leader>gU", "<cmd>DiffviewOpen --cached<cr>", desc = "Diffview (Staged Changes)" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gv", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview (Repository History)" },
      {
        "<leader>gV",
        function()
          local file = vim.api.nvim_buf_get_name(0)
          if file == "" then
            vim.notify("Current buffer has no file path", vim.log.levels.WARN)
            return
          end
          vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(file))
        end,
        desc = "Diffview (Current File History)",
      },
      { "<leader>gV", ":DiffviewFileHistory<cr>", mode = "x", desc = "Diffview (Selected Lines History)" },
    },
  },
}
