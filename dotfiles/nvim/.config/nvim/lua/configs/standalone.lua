-- lua/config/standalone.lua

-- ==========================================================
-- OPTIONS
-- ==========================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.linebreak = true

local map = vim.keymap.set
local utils = require("configs.utils")

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

vim.keymap.set("n", "<leader>ww", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

map("n", "<leader>e", utils.toggle_explorer, { desc = "Explorer (workspace root)" })

map("n", "<leader>o", utils.toggle_oil, { desc = "Oil (file ops)" })

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })

-- ==========================================================
-- LSP — navigation (Snacks picker-backed)
-- ==========================================================
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Go to declaration" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Go to implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Go to type definition" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })

-- ==========================================================
-- LSP — actions (no picker equivalent, stay native)
-- ==========================================================
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format document" })

-- ==========================================================
-- Diagnostics (d group)
-- ==========================================================
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "<leader>dl", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics list" })

-- ==========================================================
-- Symbols (s group)
-- ==========================================================
map("n", "<leader>sd", function() Snacks.picker.lsp_symbols() end, { desc = "Document symbols" })
map("n", "<leader>sw", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace symbols" })

-- ==========================================================
-- Find (f group)
-- ==========================================================
map("n", "<leader><space>",
  function() Snacks.picker.smart({ cwd = vim.g.explorer_root or utils.get_root(), hidden = true }) end,
  { desc = "Smart find" })
map("n", "<leader>ff", function() Snacks.picker.files({ cwd = vim.g.explorer_root or utils.get_root(), hidden = true }) end,
  { desc = "Find files" })
map("n", "<leader>fg", function() Snacks.picker.grep({ cwd = vim.g.explorer_root or utils.get_root(), hidden = true }) end,
  { desc = "Live grep" })
map("n", "<leader>fw", function() Snacks.picker.grep_word({ cwd = vim.g.explorer_root or utils.get_root(), hidden = true }) end,
  { desc = "Search word under cursor" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })

-- ==========================================================
-- Git (g group)
-- ==========================================================
-- lua/config/keymaps.lua
vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = vim.g.explorer_root or utils.get_root() })
end, { desc = "Lazygit (workspace root)" })
map("n", "<leader>gf", function() Snacks.picker.git_files() end, { desc = "Find git files" })

-- ==========================================================
-- Buffers / Explorer
-- ==========================================================
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete buffer" })
-- map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Explorer" })

-- ==========================================================
-- Terminal
-- ==========================================================
map({ "n", "t" }, "<C-/>", function() Snacks.terminal() end, { desc = "Terminal" })
map({ "n", "t" }, "<C-_>", function() Snacks.terminal() end, { desc = "Terminal (fallback)" }) -- some terminals send this instead of C-/

-- ==========================================================
-- Utilities
-- ==========================================================
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help" })
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Scratch buffer" })
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Zen mode" })

-- lua/config/keymaps.lua
local function cp_run()
  vim.cmd("write")
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h")
  local exe = vim.fn.expand("%:p:r")
  local ft = vim.bo.filetype
  local input = dir .. "/input.txt"
  local redirect = vim.fn.filereadable(input) == 1 and (" < " .. vim.fn.shellescape(input)) or ""

  local run_cmd
  if ft == "cpp" then
    run_cmd = ("g++ -O2 -Wall -std=c++17 %s -o %s && %s%s"):format(
      vim.fn.shellescape(file), vim.fn.shellescape(exe), vim.fn.shellescape(exe), redirect)
  elseif ft == "c" then
    run_cmd = ("gcc -O2 -Wall %s -o %s && %s%s"):format(
      vim.fn.shellescape(file), vim.fn.shellescape(exe), vim.fn.shellescape(exe), redirect)
  elseif ft == "python" then
    run_cmd = ("python3 %s%s"):format(vim.fn.shellescape(file), redirect)
  elseif ft == "java" then
    run_cmd = ("javac %s && java -cp %s %s%s"):format(
      vim.fn.shellescape(file), vim.fn.shellescape(dir), vim.fn.expand("%:t:r"), redirect)
  else
    vim.notify("No run command for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  -- run the real command, THEN drop into an interactive shell so the
  -- window stays open and you can still see the output/scroll it
  local cmd = ("%s; echo; echo '--- press <CR> or q to close ---'; read -n 1"):format(run_cmd)

  -- lua/config/keymaps.lua
  Snacks.terminal(cmd, {
    cwd = dir,
    auto_close = false,
    win = {
      style = "terminal",
      position = "float",
      border = "rounded",
      width = 0.7,
      height = 0.7,
      title = " CP Runner — " .. vim.fn.expand("%:t") .. " ",
      title_pos = "center",
    },
  })
end

vim.keymap.set("n", "<leader>rr", cp_run, { desc = "Compile & Run (CP)" })
