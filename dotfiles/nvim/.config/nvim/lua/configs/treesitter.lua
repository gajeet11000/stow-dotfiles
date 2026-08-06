local M = {}

function M.install_parsers(ensure_installed)
  local installed = require("nvim-treesitter.config").get_installed()

  local installed_set = {}
  for _, parser in ipairs(installed) do
    installed_set[parser] = true
  end

  local to_install = {}

  for _, parser in ipairs(ensure_installed) do
    if not installed_set[parser] then
      table.insert(to_install, parser)
    end
  end

  if #to_install > 0 then
    require("nvim-treesitter").install(to_install)
  end
end

return M
