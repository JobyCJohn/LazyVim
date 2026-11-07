local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Basic movement enhancements
map("n", "J", "mzJ`z")                     -- Append lines, keep cursor
map("n", "<C-d>", "<C-d>zz")               -- Scroll down, center
map("n", "<C-u>", "<C-u>zz")               -- Scroll up, center
map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Previous Search Result" })

-- Line break insertion
map("n", "]<Space>", "m`o<ESC>``")         -- Insert line below
map("n", "[<Space>", "m`O<ESC>``")         -- Insert line above

-- Line paste helpers
local function paste_lines(after)
  local contents = vim.fn.getreg(vim.v.register, false, true)
  local lines = {}
  for _ = 1, vim.v.count1 do
    vim.list_extend(lines, contents)
  end
  local view = vim.fn.winsaveview()
  vim.api.nvim_put(lines, "l", after, false)
  if not after then
    view.lnum = view.lnum + #lines
    view.topline = view.topline + #lines
  end
  vim.fn.winrestview(view)
end
map("n", "]p", function() paste_lines(true) end, { desc = "Paste Lines Below" })
map("n", "[p", function() paste_lines(false) end, { desc = "Paste Lines Above" })

-- Visual mode paste: keep register content after paste
map("x", "p", '"_dP')

-- Deletes never touch the clipboard/registers (matches vsvimrc)
map("n", "x", '"_x')
map("n", "X", '"_X')
map("n", "<Del>", '"_x')

-- Open current file directory
vim.keymap.set('n', '<leader>od', function()
  local current_dir = vim.fn.expand('%:p:h')
  if current_dir == "" then
    print("No file open")
    return
  end

  if vim.fn.has('win32') == 1 then
    vim.fn.jobstart({'cmd.exe', '/c', 'start', '', current_dir}, { detach = true })
  elseif vim.fn.has('mac') == 1 then
    vim.fn.jobstart({'open', current_dir}, { detach = true })
  else
    vim.fn.jobstart({'xdg-open', current_dir}, { detach = true })
  end
end, { desc = "Open current file directory" })

-- VSCode specific keymaps
if vim.g.vscode then
  local vscode = require("vscode")
  local function action(mode, lhs, command, desc)
    map(mode, lhs, function()
      vscode.action(command)
    end, { desc = desc })
  end

  action("n", "<leader><space>", "workbench.action.quickOpen", "Find File")
  action("n", "<leader>ff", "workbench.action.quickOpen", "Find File")
  action("n", "<leader>fr", "workbench.action.quickOpen", "Recent Files")
  action({ "n", "x" }, "<leader>/", "workbench.action.findInFiles", "Search Files")
  action({ "n", "x" }, "<leader>sg", "workbench.action.findInFiles", "Search Files")
  map("n", "<leader>sw", function()
    vscode.action("workbench.action.findInFiles", { args = { query = vim.fn.expand("<cword>") } })
  end, { desc = "Search Word" })
  action("n", "<leader>sb", "actions.find", "Search Buffer")
  action("n", "<leader>ss", "workbench.action.gotoSymbol", "Document Symbols")
  action("n", "<leader>sS", "workbench.action.showAllSymbols", "Workspace Symbols")

  action("n", "<leader>e", "workbench.view.explorer", "Explorer")
  action("n", "<leader>E", "workbench.files.action.showActiveFileInExplorer", "Reveal File")
  action("n", "<leader>bd", "workbench.action.closeActiveEditor", "Close Document")
  action("n", "<leader>bo", "workbench.action.closeOtherEditors", "Close Other Documents")

  action("n", "K", "editor.action.showHover", "Hover")
  action("n", "gd", "editor.action.revealDefinition", "Definition")
  map("n", "gr", function()
    vscode.action("editor.action.referenceSearch.trigger")
  end, { desc = "References", nowait = true })
  action("n", "gI", "editor.action.goToImplementation", "Implementation")
  action("n", "<leader>cr", "editor.action.rename", "Rename")
  action({ "n", "x" }, "<leader>ca", "editor.action.quickFix", "Code Action")
  action("n", "<leader>cf", "editor.action.formatDocument", "Format Document")
  action("x", "<leader>cf", "editor.action.formatSelection", "Format Selection")
  action("n", "<leader>cm", "workbench.view.extensions", "Extensions")

  action("n", "]d", "editor.action.marker.next", "Next Diagnostic")
  action("n", "[d", "editor.action.marker.prev", "Previous Diagnostic")

  local function goto_error(forward)
    vscode.eval_async(
      [[
      const editor = vscode.window.activeTextEditor;
      if (!editor) throw new Error("No active text editor for error navigation.");
      const errors = vscode.languages.getDiagnostics(editor.document.uri)
        .filter(d => d.severity === vscode.DiagnosticSeverity.Error)
        .sort((a, b) => a.range.start.compareTo(b.range.start));
      if (!errors.length) {
        await vscode.window.showInformationMessage("No errors in this file.");
        return;
      }
      if (!args.forward) errors.reverse();
      const cursor = editor.selection.active;
      let index = errors.findIndex(d => args.forward
        ? d.range.start.isAfter(cursor) : d.range.start.isBefore(cursor));
      if (index < 0) index = 0;
      const target = errors[(index + args.count - 1) % errors.length];
      editor.selection = new vscode.Selection(target.range.start, target.range.start);
      editor.revealRange(target.range, vscode.TextEditorRevealType.InCenterIfOutsideViewport);
      await vscode.commands.executeCommand("editor.action.showHover");
      ]],
      { args = { forward = forward, count = vim.v.count1 } }
    )
  end
  map("n", "]e", function() goto_error(true) end, { desc = "Next Error" })
  map("n", "[e", function() goto_error(false) end, { desc = "Previous Error" })

  local function goto_change(forward)
    vscode.eval_async(
      [[
      const input = vscode.window.tabGroups.activeTabGroup.activeTab?.input;
      let command;
      if (input instanceof vscode.TabInputTextDiff) {
        command = args.forward
          ? "workbench.action.compareEditor.nextChange"
          : "workbench.action.compareEditor.previousChange";
      } else if (input instanceof vscode.TabInputTextMultiDiff) {
        command = args.forward
          ? "multiDiffEditor.goToNextChange" : "multiDiffEditor.goToPreviousChange";
      } else {
        command = args.forward
          ? "workbench.action.editor.nextChange" : "workbench.action.editor.previousChange";
      }
      for (let i = 0; i < args.count; i++) {
        await vscode.commands.executeCommand(command);
      }
      ]],
      { args = { forward = forward, count = vim.v.count1 } }
    )
  end
  map("n", "]c", function() goto_change(true) end, { desc = "Next Change" })
  map("n", "[c", function() goto_change(false) end, { desc = "Previous Change" })

  action("n", "<leader>xx", "workbench.actions.view.problems", "Problems")
  action("n", "<leader>xX", "workbench.actions.view.problems", "Problems")
  action("n", "<leader>gg", "git-graph.view", "Git Graph")
  action("n", "<leader>gs", "workbench.view.scm", "Source Control")
  action("n", "<leader>aa", "workbench.action.chat.open", "Copilot Chat")
else
  local function goto_change(forward)
    if vim.wo.diff then
      vim.cmd.normal({ vim.v.count1 .. (forward and "]c" or "[c"), bang = true })
    else
      require("gitsigns").nav_hunk(forward and "next" or "prev")
    end
  end
  map("n", "]c", function() goto_change(true) end, { desc = "Next Change" })
  map("n", "[c", function() goto_change(false) end, { desc = "Previous Change" })
end