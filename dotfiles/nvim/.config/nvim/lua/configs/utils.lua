local M = {}

function M.get_root(buf)
  local root_patterns = {
    ".git",
    "pom.xml",
    "package.json",
    "Cargo.toml",
    "go.mod",
    "pyproject.toml",
    "Makefile"
  }

  buf = buf or 0
  local file = vim.api.nvim_buf_get_name(buf)

  if file == "" then
    return vim.uv.cwd()
  end

  -- goes up the cwd and finds any of the listed patterns
  local root = vim.fs.root(file, root_patterns)
  return root or vim.fn.fnamemodify(file, ":p:h")
end

function M.toggle_explorer()
  vim.g.explorer_root = vim.g.explorer_root or M.get_root()
  Snacks.explorer({ cwd = vim.g.explorer_root })
end

function M.toggle_oil()
  local file = vim.api.nvim_buf_get_name(0)
  local dir

  -- we have a buffer name, and its a normal buffer
  if file ~= "" and vim.bo.buftype == "" then
    -- use its parent directory
    dir = vim.fn.fnamemodify(file, ":p:h")
  else
    -- no buffer (empty buffer, terminal, snacks list, etc.): fall back to root
    dir = vim.g.explorer_root or M.get_root()
  end

  require("oil").toggle_float(dir)
end

function M.explorer_expand_all(picker, item)

  local Tree = require("snacks.explorer.tree")
  local Actions = require("snacks.explorer.actions")

  local node = item and Tree:node(item.file) or Tree:node(picker:cwd())

  if not node then
    return
  end

  local function expand(n)
    if n.dir and not n.open then
      Tree:toggle(n.path)
    end

    vim.schedule(function()
      Actions.update(picker, { refresh = true })

      for _, child in pairs(n.children or {}) do
        if child.dir then
          expand(child)
        end
      end
    end)
  end

  expand(node)
end

function M.explorer_collapse_all(picker, item)
  local Tree = require("snacks.explorer.tree")
  local Actions = require("snacks.explorer.actions")

  local node = item and Tree:node(item.file) or Tree:node(picker:cwd())

  if not node then
    return
  end

  local function collapse(n)
    for _, child in pairs(n.children or {}) do
      if child.dir then
        collapse(child)
      end
    end

    if n.dir and n.open then
      Tree:toggle(n.path)
    end
  end

  collapse(node)

  Actions.update(picker, { refresh = true })
end

function M.explorer_oil_here(_, item)
  if not item then
    return
  end

  local is_dir = item.dir

  local dir = is_dir
      and item.file
      or vim.fn.fnamemodify(item.file, ":h")

  local target_name = is_dir
      and nil
      or vim.fn.fnamemodify(item.file, ":t")

  require("oil").open_float(dir, {}, function()
    if not target_name then
      return
    end

    vim.schedule(function()
      local buf = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

      for lnum, line in ipairs(lines) do
        if line:find(target_name, 1, true) then
          vim.api.nvim_win_set_cursor(0, { lnum, 0 })
          break
        end
      end
    end)
  end)
end

return M
