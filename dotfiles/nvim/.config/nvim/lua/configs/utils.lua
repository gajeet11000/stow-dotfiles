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

return M
