---@diagnostic disable: undefined-global
-- vscode init lua

local vscode = require("vscode")

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamedplus" -- share system clipboard

local map = vim.keymap.set

-- File navigation via VS Code's own UI
map("n", "<leader>e", function() vscode.action("workbench.action.toggleSidebarVisibility") end,
	{ desc = "Toggle sidebar" })
map("n", "<leader>ff", function() vscode.action("workbench.action.quickOpen") end, { desc = "Quick open file" })
map("n", "<leader>fg", function() vscode.action("workbench.action.findInFiles") end, { desc = "Find in files" })

-- Window splits via VS Code's editor groups
map("n", "<leader>sv", function() vscode.action("workbench.action.splitEditor") end, { desc = "Split vertical" })
map("n", "<leader>sh", function() vscode.action("workbench.action.splitEditorDown") end, { desc = "Split horizontal" })

-- Buffer/tab navigation
map("n", "<S-l>", function() vscode.action("workbench.action.nextEditor") end, { desc = "Next editor tab" })
map("n", "<S-h>", function() vscode.action("workbench.action.previousEditor") end, { desc = "Previous editor tab" })

-- LSP-equivalent actions (mapped to VS Code's native LSP, not nvim-lspconfig)
map("n", "gd", function() vscode.action("editor.action.revealDefinition") end, { desc = "Go to definition" })
map("n", "gr", function() vscode.action("editor.action.referenceSearch.trigger") end, { desc = "Find references" })
map("n", "K", function() vscode.action("editor.action.showHover") end, { desc = "Hover docs" })
map("n", "<leader>rn", function() vscode.action("editor.action.rename") end, { desc = "Rename symbol" })
map("n", "<leader>ca", function() vscode.action("editor.action.quickFix") end, { desc = "Code action" })

-- File operations
map("n", "<leader>nf", function() vscode.action("explorer.newFile") end, { desc = "New file" })
map("n", "<leader>nd", function() vscode.action("explorer.newFolder") end, { desc = "New folder" })
map("n", "<leader>rf", function() vscode.action("renameFile") end, { desc = "Rename file" })
map("n", "<leader>df", function() vscode.action("deleteFile") end, { desc = "Delete file" })
