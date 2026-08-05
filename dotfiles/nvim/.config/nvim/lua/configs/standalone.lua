---@diagnostic disable: undefined-global
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

local map = vim.keymap.set

-- lua/configs/standalone.lua (near the top)
local root_patterns = { ".git", "lua", "package.json", "Cargo.toml", "go.mod", "pyproject.toml", "Makefile" }

local function get_root(buf)
  buf = buf or 0
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    return vim.uv.cwd()
  end
  local root = vim.fs.root(file, root_patterns)
  return root or vim.fn.fnamemodify(file, ":p:h")
end

-- Manually (re)pin the workspace, like "Open Folder" in VS Code
vim.api.nvim_create_user_command("PinRoot", function(opts)
  vim.g.explorer_root = opts.args ~= "" and vim.fn.fnamemodify(opts.args, ":p:h") or vim.fn.expand("%:p:h")
  Snacks.explorer({ cwd = vim.g.explorer_root })
  vim.notify("Workspace pinned: " .. vim.g.explorer_root)
end, { nargs = "?", complete = "dir" })
--
-- Follow the file in the explorer ONLY if it lives inside the pinned root.
-- Files opened from outside the workspace (e.g. your nvim config) leave the tree untouched.
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("explorer_workspace_follow", { clear = true }),
  callback = function(ev)
    if not vim.g.explorer_root then return end
    if vim.bo[ev.buf].buftype ~= "" then return end -- skip terminals, pickers, etc.

    local file = vim.api.nvim_buf_get_name(ev.buf)
    if file == "" then return end

    local root = vim.g.explorer_root:gsub("/$", "") .. "/"
    if file:sub(1, #root) ~= root then
      return
    end

    local picker = Snacks.picker.get({ source = "explorer" })[1]
    if not picker then return end -- explorer isn't open, nothing to update

    pcall(Snacks.explorer.reveal, { buf = ev.buf })
  end,
})

-- lua/configs/standalone.lua
-- (keep this below your get_root() function definition)
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.g.explorer_root then
      return -- already set some other way, don't override
    end
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      -- nvim was opened directly on a directory: pin to it
      vim.g.explorer_root = vim.fn.fnamemodify(arg, ":p"):gsub("/$", "")
    else
      vim.g.explorer_root = get_root()
    end
  end,
})

map("n", "<leader>e", function()
  vim.g.explorer_root = vim.g.explorer_root or get_root()
  Snacks.explorer({ cwd = vim.g.explorer_root })
end, { desc = "Explorer (workspace root)" })

map("n", "<leader>o", function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir

  if file ~= "" and vim.bo.buftype == "" then
    -- a real file buffer is focused: use its directory
    dir = vim.fn.fnamemodify(file, ":p:h")
  else
    -- no buffer (empty buffer, terminal, snacks list, etc.): fall back to root
    dir = vim.g.explorer_root or get_root()
  end

  require("oil").toggle_float(dir)
end, { desc = "Oil (file ops)" })

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
map("n", "<leader><space>", function() Snacks.picker.smart({ cwd = vim.g.explorer_root or get_root(), hidden = true }) end,
  { desc = "Smart find" })
map("n", "<leader>ff", function() Snacks.picker.files({ cwd = vim.g.explorer_root or get_root(), hidden = true }) end,
  { desc = "Find files" })
map("n", "<leader>fg", function() Snacks.picker.grep({ cwd = vim.g.explorer_root or get_root(), hidden = true }) end,
  { desc = "Live grep" })
map("n", "<leader>fw", function() Snacks.picker.grep_word({ cwd = vim.g.explorer_root or get_root(), hidden = true }) end,
  { desc = "Search word under cursor" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })

-- ==========================================================
-- Git (g group)
-- ==========================================================
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "LazyGit" })
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
