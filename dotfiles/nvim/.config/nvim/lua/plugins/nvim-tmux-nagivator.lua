return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local path = vim.fn.glob("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua")
    if path ~= "" then
      dofile(path)
    end
  end,
}
