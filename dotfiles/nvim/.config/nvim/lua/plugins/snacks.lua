return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  cond = not vim.g.vscode,

  opts = {
    bigfile = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },

    dashboard = require("configs.snacks.dashboard"),

    picker = {
      enabled = true,
      sources = {
        explorer = require("configs.snacks.explorer")
      }
    },

    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
  },

  keys = {
    { "<leader>e", false },
  },
}
