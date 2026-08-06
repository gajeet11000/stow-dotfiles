return {
  "catppuccin/nvim",
  cond = not vim.g.vscode,
  name = "catppuccin",
  priority = 1000,        -- load before other plugins, since they may check `vim.g.colors_name`
  opts = {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    integrations = {
      treesitter = true,
      native_lsp = { enabled = true }, -- harmless to leave true even without LSP yet
      lualine = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
